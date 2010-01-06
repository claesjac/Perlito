package main;

use FindBin '$Bin';
use lib ("$Bin/lib5");
use strict;

BEGIN {
    $::_V6_COMPILER_NAME    = 'MiniPerl6';
    $::_V6_COMPILER_VERSION = '2.0';
}

use MiniPerl6::Perl5::Runtime;
use MiniPerl6::Perl5::Match;

package Main;
use MiniPerl6::Perl5::Emitter;
use MiniPerl6::Grammar;
use MiniPerl6::Grammar::Regex;
use MiniPerl6::Emitter::Token;

my ( @switch_e, $source, $source_filename, $result );
my @comp_unit;
my $backend = 'perl5';
my $tmp_filename = 'tmp';
my $execute = 1;
my $verbose = 0;
my @args = @ARGV;
while (@args) {
    if ( $args[0] eq '--verbose' ) {
        $verbose = 1;
        shift @args;
        redo;
    }
    if ( $args[0] eq '-B' || $args[0] eq '-C' ) {
        if ( @args > 1 ) {
            $args[1] = $args[0] . $args[1];
            shift @args;
        }
        else {
            die("Missing argument for $args[0] option");
        }
    } 
    if ( $args[0] =~ /^-B(.*)/ ) {
        $execute = 1;
        $backend = $1;
        shift @args;
        redo;
    }
    if ( $args[0] =~ /^-C(.*)/ ) {
        $execute = 0;
        $backend = $1;
        shift @args;
        redo;
    }
    if ( $args[0] eq '-e' ) {
        my ($switch, $source) = (shift @args, shift @args);
        push @switch_e, $source;
        redo;
    }
    last;
}

$source_filename = shift @args if @args;

if ( $verbose ) {
    warn "compilation parameters:\n";
    warn "\tbackend         '$backend'\n";
    warn "\ttmp_filename    '$tmp_filename'\n";
    warn "\texecute         '$execute'\n";
    warn "\tsource_filename '$source_filename'\n";
    warn "\tBin             '$::Bin'\n";
    warn "\te               '${_}'\n" for @switch_e;
}

if (@switch_e) {
    $source = join('; ', @switch_e);
}
elsif ($source_filename) {
    open FILE, $source_filename
      or die "Cannot read $source_filename\n";
    local $/ = undef;
    $source = <FILE>;
    close FILE;
    warn "read " . length($source) . " chars from $source_filename\n" if $verbose;
}
else {
    warn "reading input from STDIN\n" if $verbose;
    local $/ = undef;
    $source = <STDIN>;
}

if ( $source_filename =~ /\.p5ast$/ ) {
    # source code was precompiled to AST, dumped as a perl5 structure
    warn "input format is precompiled AST\n" if $verbose;
    @comp_unit = @{ eval $source };
}
else {
    if ( !$source_filename ) {
        # Kludge - make an implicit Main explicit.
        warn "adding implicit 'Main'\n" if $verbose && $source !~ /class/;
        $source = "class Main { $source }" if $source !~ /class/;
    }

    if ( $backend eq 'go' ) {
        my $lib_source_filename = 'lib/MiniPerl6/Go/Prelude.pm';
        open FILE, $::Bin . '/' . $lib_source_filename
          or die "Cannot read $::Bin/$lib_source_filename\n";
        local $/ = undef;
        $source = <FILE> . "\n" . $source;
        close FILE;
        warn "included Go Prelude.pm\n" if $verbose;
    }

    my $pos = 0;
    while ( $pos < length($source) ) {
        warn "parsing at pos $pos\n" if $verbose;
        my $p = MiniPerl6::Grammar->comp_unit( $source, $pos );
        push @comp_unit, $$p;
        $pos = $p->to;
    }
}

warn "starting emitter phase\n" if $verbose;
if ( $backend eq 'lisp' ) {
    require MiniPerl6::Lisp::Emitter;
    $result .=  ";; Do not edit this file - Generated by $::_V6_COMPILER_NAME $::_V6_COMPILER_VERSION\n";
    for my $p ( @comp_unit ) {
        $result .=  $p->emit_lisp() . "\n";
    }

    if ( $execute ) {
        die "execute Lisp not implemented\n";
    }
}
if ( $backend eq 'js' ) {
    require MiniPerl6::Javascript::Emitter;
    $result .=  "// Do not edit this file - Generated by $::_V6_COMPILER_NAME $::_V6_COMPILER_VERSION\n";
    for my $p ( @comp_unit ) {
        $result .=  $p->emit_javascript() . "\n";
    }

    if ( $execute ) {
        die "execute Javascript not implemented\n";
    }
}
if ( $backend eq 'go' ) {
    require MiniPerl6::Go::Emitter;
    $result .=  "// Do not edit this file - Generated by $::_V6_COMPILER_NAME $::_V6_COMPILER_VERSION\n";

    my $lib_source_filename = 'lib/MiniPerl6/Go/Runtime.go';
    $result .= "// include file: $lib_source_filename\n";
    open FILE, $::Bin . '/' . $lib_source_filename
      or die "Cannot read $::Bin/$lib_source_filename\n";
    local $/ = undef;
    $result .= <FILE>;
    close FILE;
    $result .= "// end include file: $lib_source_filename\n";

    $result .= CompUnit::emit_go_program( \@comp_unit );

    if ( $execute ) {
        open( OUT, '>', $tmp_filename . '.go' )
          or die "Cannot write to ${tmp_filename}.go\n";
        print OUT $result;
        close(OUT);
        unlink $tmp_filename . '.6';
        unlink '6.out';
        `6g $tmp_filename.go`;
        `6l $tmp_filename.6`;
        exec "./6.out"
            or die "can't execute";
    }
}
if ( $backend eq 'perl5' ) {
    $result .=  "# Do not edit this file - Generated by $::_V6_COMPILER_NAME $::_V6_COMPILER_VERSION\n";
    $result .=  "use v5;\n";
    $result .=  "use strict;\n";
    $result .=  "use MiniPerl6::Perl5::Runtime;\n";
    $result .=  "use MiniPerl6::Perl5::Match;\n";
    for my $p ( @comp_unit ) {
        $result .=  "{\n" . $p->emit() . "}\n";
    }
    $result .=  "1;\n";

    if ( $execute ) {
        eval $result;
        warn $@ if $@;
    }
}
if ( $backend eq 'ast-perl5' ) {
    require Data::Dumper;
    local $Data::Dumper::Terse    = 1;
    local $Data::Dumper::Sortkeys = 1;
    local $Data::Dumper::Indent   = 1;
    $result .=  Data::Dumper::Dumper( \@comp_unit );
}

if ( !$execute ) {
    print $result;
}

warn "done\n" if $verbose;
