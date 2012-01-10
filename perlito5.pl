# Do not edit this file - Generated by Perlito5 8.0
use v5;
use utf8;
use strict;
use warnings;
no warnings ('redefine', 'once', 'void', 'uninitialized', 'misc', 'recursion');
use Perlito5::Perl5::Runtime;
use Perlito5::Perl5::Prelude;
our $MATCH = Perlito5::Match->new();
{
package main;
    sub new { shift; bless { @_ }, "main" }
    use v5;
    package Main;
    use Perlito5::Emitter::Token;
    use Perlito5::Expression;
    use Perlito5::Grammar::Control;
    use Perlito5::Grammar::Regex;
    use Perlito5::Grammar;
    use Perlito5::Javascript::Emitter;
    use Perlito5::Macro;
    use Perlito5::Perl5::Emitter;
    use Perlito5::Precedence;
    use Perlito5::Runtime;
    ((my  $_V6_COMPILER_NAME) = 'Perlito5');
    ((my  $_V6_COMPILER_VERSION) = '8.0');
    ((my  $source) = '');
    ((my  $backend) = '');
    ((my  $execute) = 0);
    ((my  $verbose) = 0);
    ((my  $comp_units) = do {
    (my  $List_a = bless [], 'ARRAY');
    (my  $List_v = bless [], 'ARRAY');
    $List_a
});
    ((my  $perl5lib) = '.' . chr(47) . 'src5' . chr(47) . 'lib');
    ((my  $expand_use) = 1);
    if (($verbose)) {
        warn((chr(47) . chr(47) . ' Perlito5 compiler'));
        warn((chr(47) . chr(47) . ' ARGV: ' . chr(64) . 'ARGV'))
    };
    (my  $Hash_module_seen = bless {}, 'HASH');
    sub module_name {
        my $List__ = bless \@_, "ARRAY";
        ((my  $grammar) = $List__->[0]);
        ((my  $str) = $List__->[1]);
        ((my  $pos) = $List__->[2]);
        ((my  $MATCH) = Perlito5::Match->new(('str' => $str), ('from' => $pos), ('to' => $pos), ('bool' => 1)));
        (($MATCH)->{bool} = ((do {
    ((my  $pos1) = $MATCH->to());
    (do {
    ((do {
    ((my  $m2) = Perlito5::Grammar->ident($str, $MATCH->to()));
    if (($m2)) {
        (($MATCH)->{to} = $m2->to());
        ($MATCH->{'Perlito5::Grammar.ident'} = $m2);
        1
    }
    else {
        0
    }
}) && (do {
    ((my  $pos1) = $MATCH->to());
    ((do {
    ((((('::' eq substr($str, $MATCH->to(), 2)) && ((($MATCH)->{to} = (2 + $MATCH->to()))))) && (do {
    ((my  $m2) = $grammar->module_name($str, $MATCH->to()));
    if (($m2)) {
        (($MATCH)->{to} = $m2->to());
        ($MATCH->{'module_name'} = $m2);
        1
    }
    else {
        0
    }
})) && (((do {
    ($MATCH->{capture} = (do {
    (my  $List_a = bless [], 'ARRAY');
    (my  $List_v = bless [], 'ARRAY');
    push( @{$List_a}, ('' . $MATCH->{'Perlito5::Grammar.ident'}) );
    ($List_v = ((${$MATCH->{'module_name'}})));
    for my $x ( @{(bless [0 .. ((scalar( @{$List_v} ) - 1))], 'ARRAY')} ) {
        push( @{$List_a}, $List_v->[$x] )
    };
    $List_a
}))
}) || 1)))
}) || (do {
    (($MATCH)->{to} = $pos1);
    ((1 && (((do {
    ($MATCH->{capture} = (do {
    (my  $List_a = bless [], 'ARRAY');
    (my  $List_v = bless [], 'ARRAY');
    push( @{$List_a}, ('' . $MATCH->{'Perlito5::Grammar.ident'}) );
    $List_a
}))
}) || 1))))
}))
}))
})
})));
        $MATCH
    };
    sub modulename_to_filename {
        my $List__ = bless \@_, "ARRAY";
        ((my  $s) = shift());
        ((my  $ident) = Main->module_name($s, 0));
        return scalar (Main::join((${$ident}), (chr(47))))
    };
    sub expand_use {
        my $List__ = bless \@_, "ARRAY";
        ((my  $stmt) = shift());
        ((my  $module_name) = $stmt->mod());
        if (((($module_name eq 'v5') || ($module_name eq 'strict')) || ($module_name eq 'feature'))) {
            return ()
        };
        if ((!(($Hash_module_seen->{$module_name})))) {
            ($Hash_module_seen->{$module_name} = 1);
            if (((($backend eq 'perl5')) || (($backend eq 'ast-perl5')))) {

            }
            else {
                ((my  $filename) = $module_name);
                ($filename = ($perl5lib . chr(47) . modulename_to_filename($filename) . '.pm'));
                if (($verbose)) {
                    warn((chr(47) . chr(47) . ' now loading: '), $filename)
                };
                ((my  $source) = IO::slurp($filename));
                ((my  $m) = Perlito5::Grammar->exp_stmts($source, 0));
                add_comp_unit(do {
    (my  $List_a = bless [], 'ARRAY');
    (my  $List_v = bless [], 'ARRAY');
    push( @{$List_a}, CompUnit->new(('name' => 'main'), ('body' => ${$m})) );
    $List_a
})
            }
        }
    };
    sub add_comp_unit {
        my $List__ = bless \@_, "ARRAY";
        ((my  $parse) = shift());
        for my $comp_unit ( @{($parse)} ) {
            if ((($expand_use && Main::isa($comp_unit, 'Use')))) {
                expand_use($comp_unit)
            }
            else {
                if ((Main::isa($comp_unit, 'CompUnit'))) {
                    if (($verbose)) {
                        warn(('parsed comp_unit: ' . chr(39)), $comp_unit->name(), (chr(39)))
                    };
                    for my $stmt ( @{(($comp_unit->body()))} ) {
                        if ((($expand_use && Main::isa($stmt, 'Use')))) {
                            expand_use($stmt)
                        }
                    }
                }
            };
            push( @{($comp_units)}, $comp_unit )
        }
    };
    if (((((\@ARGV)->[0] eq '-v')) || (((\@ARGV)->[0] eq '--verbose')))) {
        ($verbose = 1);
        shift( @{(\@ARGV)} )
    };
    if (((substr((\@ARGV)->[0], 0, 2) eq '-C'))) {
        ($backend = substr((\@ARGV)->[0], 2, 10));
        ($execute = 0);
        shift( @{(\@ARGV)} );
        if ((((($backend eq 'perl5')) || (($backend eq 'python'))) || (($backend eq 'ruby')))) {
            ($expand_use = 0)
        }
    };
    if (((substr((\@ARGV)->[0], 0, 2) eq '-B'))) {
        ($backend = substr((\@ARGV)->[0], 2, 10));
        ($execute = 1);
        shift( @{(\@ARGV)} );
        if ((((($backend eq 'perl5')) || (($backend eq 'python'))) || (($backend eq 'ruby')))) {
            ($expand_use = 0)
        }
    };
    if (((((\@ARGV)->[0] eq '-V')) || (((\@ARGV)->[0] eq '--version')))) {
        ($backend = '');
        Main::say($_V6_COMPILER_NAME, (' '), $_V6_COMPILER_VERSION);
        shift( @{(\@ARGV)} )
    }
    else {
        if ((((((\@ARGV)->[0] eq '-h')) || (((\@ARGV)->[0] eq '--help'))) || (($backend eq '')))) {
            ($backend = '');
            Main::say($_V6_COMPILER_NAME, (' '), $_V6_COMPILER_VERSION, (chr(10) . 'perlito5 [switches] [programfile]' . chr(10) . '  switches:' . chr(10) . '    -h --help' . chr(10) . '    -v --verbose' . chr(10) . '    -V --version' . chr(10) . '    -Ctarget        target backend: js, perl5, ast-perl5' . chr(10) . '    --expand_use --noexpand_use' . chr(10) . '                    expand ' . chr(39) . 'use' . chr(39) . ' statements at compile time' . chr(10) . '    -e program      one line of program (omit programfile)' . chr(10)));
            shift( @{(\@ARGV)} )
        }
    };
    if ((((\@ARGV)->[0] eq '--expand_use'))) {
        ($expand_use = 1);
        shift( @{(\@ARGV)} )
    };
    if ((((\@ARGV)->[0] eq '--noexpand_use'))) {
        ($expand_use = 0);
        shift( @{(\@ARGV)} )
    };
    if ((($backend && (\@ARGV)))) {
        (my  $prelude_filename);
        if ((($backend eq 'js'))) {
            ($prelude_filename = ($perl5lib . chr(47) . 'Perlito5' . chr(47) . 'Javascript' . chr(47) . 'Prelude.pm'))
        };
        if (($prelude_filename)) {
            if (($verbose)) {
                warn((chr(47) . chr(47) . ' loading lib: '), $prelude_filename)
            };
            ($source = IO::slurp($prelude_filename));
            ((my  $m) = Perlito5::Grammar->exp_stmts($source, 0));
            add_comp_unit(${$m})
        };
        if ((((\@ARGV)->[0] eq '-e'))) {
            shift( @{(\@ARGV)} );
            if (($verbose)) {
                warn((chr(47) . chr(47) . ' source from command line: '), (\@ARGV)->[0])
            };
            ($source = shift( @{(\@ARGV)} ))
        }
        else {
            if (($verbose)) {
                warn((chr(47) . chr(47) . ' source from file: '), (\@ARGV)->[0])
            };
            ($source = IO::slurp(shift( @{(\@ARGV)} )))
        };
        if (($verbose)) {
            warn((chr(47) . chr(47) . ' backend: '), $backend);
            warn(('now parsing'))
        };
        ((my  $m) = Perlito5::Grammar->exp_stmts($source, 0));
        add_comp_unit(${$m});
        ($comp_units = do {
    (my  $List_a = bless [], 'ARRAY');
    (my  $List_v = bless [], 'ARRAY');
    push( @{$List_a}, CompUnit->new(('name' => 'main'), ('body' => $comp_units)) );
    $List_a
});
        if ((($backend eq 'ast-perl5'))) {
            Main::say((chr(35) . ' AST dump - do not edit this file - Generated by '), $_V6_COMPILER_NAME, (' '), $_V6_COMPILER_VERSION);
            Main::say(($comp_units))
        };
        if ((($backend eq 'perl5'))) {
            Main::say((chr(35) . ' Do not edit this file - Generated by '), $_V6_COMPILER_NAME, (' '), $_V6_COMPILER_VERSION);
            Main::print(CompUnit::emit_perl5_program($comp_units))
        };
        if ((($backend eq 'js'))) {
            Main::say((chr(47) . chr(47) . ' Do not edit this file - Generated by '), $_V6_COMPILER_NAME, (' '), $_V6_COMPILER_VERSION);
            ((my  $filename) = ($perl5lib . chr(47) . 'Perlito5' . chr(47) . 'Javascript' . chr(47) . 'Runtime.js'));
            if (($verbose)) {
                warn((chr(47) . chr(47) . ' now loading: '), $filename)
            };
            ((my  $source) = IO::slurp($filename));
            Main::say($source);
            Main::print(CompUnit::emit_javascript_program($comp_units))
        };
        if ((($backend eq 'java'))) {
            Main::say((chr(47) . chr(47) . ' Do not edit this file - Generated by '), $_V6_COMPILER_NAME, (' '), $_V6_COMPILER_VERSION);
            Main::print(CompUnit::emit_java_program($comp_units))
        }
    }
}

1;
