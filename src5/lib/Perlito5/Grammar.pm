package Perlito5::Grammar;

use Perlito5::Expression;
# use Perlito5::Grammar::Regex;
use Perlito5::Grammar::Control;
use Perlito5::Grammar::String;

sub word {
    bless {
        str  => $_[1],
        from => $_[2],
        to   => $_[2] + 1,
        bool => substr( $_[1], $_[2], 1 ) =~ m/\w/,
      },
      'Perlito5::Match';
}

sub digit {
    bless {
        str  => $_[1],
        from => $_[2],
        to   => $_[2] + 1,
        bool => substr( $_[1], $_[2], 1 ) =~ m/\d/,
      },
      'Perlito5::Match';
}

sub space {
    bless {
        str  => $_[1],
        from => $_[2],
        to   => $_[2] + 1,
        bool => substr( $_[1], $_[2], 1 ) =~ m/\s/,
      },
      'Perlito5::Match';
}

token is_newline {
    | \c10
    | \c13
};

token not_newline {
    <!before \n> .
};

token ident {
    <!before \d > <.word>+
};

token full_ident {
    <.ident>  [ '::' <.ident> ]*
};

token namespace_before_ident {
    <.ident> <before '::'>   [ '::' <.ident> <before '::'> ]*
};
token optional_namespace_before_ident {
    | <namespace_before_ident> '::'*
        { $MATCH->{"capture"} = $MATCH->{"namespace_before_ident"}->flat() }
    | '::'
        { $MATCH->{"capture"} = 'main' }
    | ''
        { $MATCH->{"capture"} = '' }
};

token pod_pod_begin {
    |   \n '=cut' \N*
    |   . \N* <.pod_pod_begin>
};

token pod_begin {
    |   \n '=end' \N*
    |   . \N* <.pod_begin>
};

token ws {
    [
    |   '#' \N*
    |
        [ \c10 \c13?
        | \c13 \c10?
        ]

        <.Perlito5::Grammar::String.here_doc>

        [
        |  '='  [
                |  'pod'    <.pod_pod_begin>
                |  'head1'  <.pod_pod_begin>
                |  'begin'  <.pod_begin>
                |  'for'    <.pod_begin>  # TODO - fixme: recognize a single paragraph (double-newline)
                ]
        |  ''
        ]
    |   \s
    ]+
};

token opt_ws  {  <.ws>?  };
token opt_ws2 {  <.ws>?  };
token opt_ws3 {  <.ws>?  };

token exp_stmts2 { <exp_stmts> { $MATCH->{"capture"} = $MATCH->{"exp_stmts"}->flat() } };

token exp {
    <Perlito5::Expression.exp_parse>
        { $MATCH->{"capture"} = $MATCH->{"Perlito5::Expression.exp_parse"}->flat() }
};

token exp2 {
    <Perlito5::Expression.exp_parse>
        { $MATCH->{"capture"} = $MATCH->{"Perlito5::Expression.exp_parse"}->flat() }
};

token opt_ident {
    | <ident>  { $MATCH->{"capture"} = $MATCH->{"ident"}->flat() }
    | ''       { $MATCH->{"capture"} = 'postcircumfix:<( )>' }
};

token opt_type {
    |   '::'?  <full_ident>   { $MATCH->{"capture"} = $MATCH->{"full_ident"}->flat() }
    |   ''                    { $MATCH->{"capture"} = '' }
};

token var_sigil     { \$ |\% |\@ |\& | \* };

token var_name      { <full_ident> | <digit> };

token var_ident {
    <var_sigil> <optional_namespace_before_ident> <var_name>
    {
        $MATCH->{"capture"} = Perlito5::AST::Var->new(
            sigil       => $MATCH->{"var_sigil"}->flat(),
            namespace   => $MATCH->{"optional_namespace_before_ident"}->flat(),
            name        => $MATCH->{"var_name"}->flat(),
        )
    }
};

token exponent {
    [ 'e' | 'E' ]  [ '+' | '-' | '' ]  \d+
};

token val_num {
    [
    |   \. \d+    <.exponent>?    # .10 .10e10
    |   \.        <.exponent>     # .e10 
    |   \d+     [ <.exponent>  |   \. <!before \. > \d*  <.exponent>? ]
    ]
    { $MATCH->{"capture"} = Perlito5::AST::Val::Num->new( num => $MATCH->flat() ) }
};

token digits {
    \d+
};

token val_int {
    [ '0' ['x'|'X'] <.word>+   # XXX test for hex number
    | '0' ['b'|'B'] [ 0 | 1 ]+
    | '0'  \d+        # XXX test for octal number
    ]
        { $MATCH->{"capture"} = Perlito5::AST::Val::Int->new( int => oct($MATCH->flat()) ) }
    | \d+
        { $MATCH->{"capture"} = Perlito5::AST::Val::Int->new( int => $MATCH->flat() ) }
};

my @PKG;
token exp_stmts {
    {
        push @PKG, $Perlito5::PKG_NAME
    }
    <Perlito5::Expression.delimited_statement>*
    { 
        $Perlito5::PKG_NAME = pop @PKG;
        $MATCH->{"capture"} = [ map( $_->capture, @{ $MATCH->{"Perlito5::Expression.delimited_statement"} } ) ]
    }
};

token args_sig {
    [ ';' | '\\' | '[' | ']' | '*' | '+' | '@' | '%' | '$' | '&' ]*
};

token prototype {
    |   <.opt_ws> \( <.opt_ws>  <args_sig>  <.opt_ws>  \)
        { $MATCH->{"capture"} = "" . $MATCH->{"args_sig"}->flat() }
    |   { $MATCH->{"capture"} = '*undef*' }   # default signature
};

token anon_sub_def {
    <prototype> <.opt_ws> \{ <.opt_ws> <exp_stmts> <.opt_ws>
    [   \}     | { die 'Syntax Error in anon sub' } ]
    {
        my $sig  = $MATCH->{"prototype"}->flat();
        $sig = undef if $sig eq '*undef*';
        $MATCH->{"capture"} = Perlito5::AST::Sub->new(
            name  => undef, 
            namespace => undef,
            sig   => $sig, 
            block => $MATCH->{"exp_stmts"}->flat() 
        ) 
    }
};


token named_sub_def {
    <optional_namespace_before_ident> <ident> <prototype> <.opt_ws> \{ <.opt_ws> <exp_stmts> <.opt_ws>
    [   \}     | { die 'Syntax Error in sub \'', $MATCH->{"ident"}->flat(), '\'' } ]
    {
        my $name = $MATCH->{"ident"}->flat();
        my $sig  = $MATCH->{"prototype"}->flat();
        $sig = undef if $sig eq '*undef*';
        my $namespace = $MATCH->{"optional_namespace_before_ident"}->flat();
        if ( $name ) {
            # say "sub $Perlito5::PKG_NAME :: $name ( $sig )";
            $namespace = $Perlito5::PKG_NAME unless $namespace;

            my $full_name = "${namespace}::$name";
            warn "Subroutine $full_name redefined"
                if exists $Perlito5::PROTO->{$full_name};

            $Perlito5::PROTO->{$full_name} = $sig;
        }
        $MATCH->{"capture"} = Perlito5::AST::Sub->new(
            name  => $name, 
            namespace => $namespace,
            sig   => $sig, 
            block => $MATCH->{"exp_stmts"}->flat() 
        ) 
    }
};


=begin

=head1 NAME

Perlito5::Grammar - Grammar for Perlito

=head1 SYNOPSIS

    my $match = $source.parse;
    $match->flat();    # generated Perlito AST

=head1 DESCRIPTION

This module generates a syntax tree for the Perlito compiler.

=head1 AUTHORS

Flavio Soibelmann Glock <fglock@gmail.com>.
The Pugs Team E<lt>perl6-compiler@perl.orgE<gt>.

=head1 SEE ALSO

The Perl 6 homepage at L<http://dev.perl.org/perl6>.

The Pugs homepage at L<http://pugscode.org/>.

=head1 COPYRIGHT

Copyright 2006, 2009, 2010, 2011, 2012 by Flavio Soibelmann Glock, Audrey Tang and others.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=end
