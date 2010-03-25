# Do not edit this file - Generated by MiniPerl6 4.1
use v5;
use strict;
use MiniPerl6::Perl5::Runtime;
our $MATCH = MiniPerl6::Match->new();
{
package MiniPerl6::Grammar;
sub new { shift; bless { @_ }, "MiniPerl6::Grammar" }
sub control { my $grammar = $_[0]; my $str = $_[1]; my $pos = $_[2]; my  $MATCH; ($MATCH = MiniPerl6::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, )); (($MATCH)->{bool} = do { (my  $pos1 = $MATCH->to()); (do { (do { (my  $m2 = $grammar->ctrl_return($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());($MATCH->{'ctrl_return'} = $m2);1 } else { 0 } } && (do { ($MATCH->{capture} = (${$MATCH->{'ctrl_return'}})) } || 1)) } || (do { (($MATCH)->{to} = $pos1); (do { (my  $m2 = $grammar->ctrl_leave($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());($MATCH->{'ctrl_leave'} = $m2);1 } else { 0 } } && (do { ($MATCH->{capture} = (${$MATCH->{'ctrl_leave'}})) } || 1)) } || (do { (($MATCH)->{to} = $pos1); (do { (my  $m2 = $grammar->if($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());($MATCH->{'if'} = $m2);1 } else { 0 } } && (do { ($MATCH->{capture} = (${$MATCH->{'if'}})) } || 1)) } || (do { (($MATCH)->{to} = $pos1); (do { (my  $m2 = $grammar->when($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());($MATCH->{'when'} = $m2);1 } else { 0 } } && (do { ($MATCH->{capture} = (${$MATCH->{'when'}})) } || 1)) } || (do { (($MATCH)->{to} = $pos1); (do { (my  $m2 = $grammar->for($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());($MATCH->{'for'} = $m2);1 } else { 0 } } && (do { ($MATCH->{capture} = (${$MATCH->{'for'}})) } || 1)) } || (do { (($MATCH)->{to} = $pos1); (do { (my  $m2 = $grammar->while($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());($MATCH->{'while'} = $m2);1 } else { 0 } } && (do { ($MATCH->{capture} = (${$MATCH->{'while'}})) } || 1)) } || do { (($MATCH)->{to} = $pos1); (do { (my  $m2 = $grammar->apply($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());($MATCH->{'apply'} = $m2);1 } else { 0 } } && (do { ($MATCH->{capture} = (${$MATCH->{'apply'}})) } || 1)) })))))) }); $MATCH };
sub if { my $grammar = $_[0]; my $str = $_[1]; my $pos = $_[2]; my  $MATCH; ($MATCH = MiniPerl6::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, )); (($MATCH)->{bool} = do { (my  $pos1 = $MATCH->to()); do { ((('i' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && ((('f' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && (do { (my  $m2 = $grammar->ws($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());1 } else { 0 } } && (do { (my  $m2 = $grammar->exp($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());($MATCH->{'exp'} = $m2);1 } else { 0 } } && (do { (my  $m2 = $grammar->opt_ws($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());1 } else { 0 } } && ((('{' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && (do { (my  $m2 = $grammar->opt_ws($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());1 } else { 0 } } && (do { (my  $m2 = $grammar->exp_stmts($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());($MATCH->{'exp_stmts'} = $m2);1 } else { 0 } } && (do { (my  $m2 = $grammar->opt_ws($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());1 } else { 0 } } && ((('}' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && do { (my  $pos1 = $MATCH->to()); (do { (do { (my  $m2 = $grammar->opt_ws($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());1 } else { 0 } } && ((('e' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && ((('l' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && ((('s' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && ((('e' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && (do { (my  $m2 = $grammar->opt_ws($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());1 } else { 0 } } && ((('{' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && (do { (my  $m2 = $grammar->opt_ws($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());1 } else { 0 } } && (do { (my  $m2 = $grammar->exp_stmts2($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());($MATCH->{'exp_stmts2'} = $m2);1 } else { 0 } } && (do { (my  $m2 = $grammar->opt_ws($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());1 } else { 0 } } && ((('}' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && (do { ($MATCH->{capture} = (If->new( 'cond' => ${$MATCH->{'exp'}},'body' => ${$MATCH->{'exp_stmts'}},'otherwise' => ${$MATCH->{'exp_stmts2'}}, ))) } || 1)))))))))))) } || (do { (($MATCH)->{to} = $pos1); (do { (my  $m2 = $grammar->opt_ws($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());1 } else { 0 } } && ((('e' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && ((('l' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && ((('s' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && (do { (my  $m2 = $grammar->if($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());($MATCH->{'if'} = $m2);1 } else { 0 } } && (do { ($MATCH->{capture} = (If->new( 'cond' => ${$MATCH->{'exp'}},'body' => ${$MATCH->{'exp_stmts'}},'otherwise' => [${$MATCH->{'if'}}], ))) } || 1)))))) } || do { (($MATCH)->{to} = $pos1); (do { ($MATCH->{capture} = (If->new( 'cond' => ${$MATCH->{'exp'}},'body' => ${$MATCH->{'exp_stmts'}},'otherwise' => [], ))) } || 1) })) })))))))))) } }); $MATCH };
sub when { my $grammar = $_[0]; my $str = $_[1]; my $pos = $_[2]; my  $MATCH; ($MATCH = MiniPerl6::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, )); (($MATCH)->{bool} = do { (my  $pos1 = $MATCH->to()); do { ((('w' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && ((('h' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && ((('e' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && ((('n' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && (do { (my  $m2 = $grammar->ws($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());1 } else { 0 } } && (do { (my  $m2 = $grammar->exp_seq($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());($MATCH->{'exp_seq'} = $m2);1 } else { 0 } } && (do { (my  $m2 = $grammar->opt_ws($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());1 } else { 0 } } && ((('{' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && (do { (my  $m2 = $grammar->opt_ws($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());1 } else { 0 } } && (do { (my  $m2 = $grammar->exp_stmts($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());($MATCH->{'exp_stmts'} = $m2);1 } else { 0 } } && (do { (my  $m2 = $grammar->opt_ws($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());1 } else { 0 } } && ((('}' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && (do { ($MATCH->{capture} = (When->new( 'parameters' => ${$MATCH->{'exp_seq'}},'body' => ${$MATCH->{'exp_stmts'}}, ))) } || 1))))))))))))) } }); $MATCH };
sub for { my $grammar = $_[0]; my $str = $_[1]; my $pos = $_[2]; my  $MATCH; ($MATCH = MiniPerl6::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, )); (($MATCH)->{bool} = do { (my  $pos1 = $MATCH->to()); do { ((('f' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && ((('o' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && ((('r' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && (do { (my  $m2 = $grammar->ws($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());1 } else { 0 } } && (do { (my  $m2 = $grammar->exp($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());($MATCH->{'exp'} = $m2);1 } else { 0 } } && (do { (my  $m2 = $grammar->opt_ws($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());1 } else { 0 } } && ((('->' eq substr($str, $MATCH->to(), 2)) ? (1 + (($MATCH)->{to} = (2 + $MATCH->to()))) : 0) && (do { (my  $m2 = $grammar->opt_ws($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());1 } else { 0 } } && (do { (my  $m2 = $grammar->var_ident($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());($MATCH->{'var_ident'} = $m2);1 } else { 0 } } && (do { (my  $m2 = $grammar->ws($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());1 } else { 0 } } && ((('{' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && (do { (my  $m2 = $grammar->opt_ws($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());1 } else { 0 } } && (do { (my  $m2 = $grammar->exp_stmts($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());($MATCH->{'exp_stmts'} = $m2);1 } else { 0 } } && (do { (my  $m2 = $grammar->opt_ws($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());1 } else { 0 } } && ((('}' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && (do { ($MATCH->{capture} = (For->new( 'cond' => ${$MATCH->{'exp'}},'topic' => ${$MATCH->{'var_ident'}},'body' => ${$MATCH->{'exp_stmts'}}, ))) } || 1)))))))))))))))) } }); $MATCH };
sub while { my $grammar = $_[0]; my $str = $_[1]; my $pos = $_[2]; my  $MATCH; ($MATCH = MiniPerl6::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, )); (($MATCH)->{bool} = do { (my  $pos1 = $MATCH->to()); do { ((('w' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && ((('h' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && ((('i' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && ((('l' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && ((('e' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && (do { (my  $m2 = $grammar->ws($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());1 } else { 0 } } && (do { (my  $m2 = $grammar->exp($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());($MATCH->{'exp'} = $m2);1 } else { 0 } } && (do { (my  $m2 = $grammar->ws($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());1 } else { 0 } } && ((('{' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && (do { (my  $m2 = $grammar->opt_ws($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());1 } else { 0 } } && (do { (my  $m2 = $grammar->exp_stmts($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());($MATCH->{'exp_stmts'} = $m2);1 } else { 0 } } && (do { (my  $m2 = $grammar->opt_ws($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());1 } else { 0 } } && ((('}' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && (do { ($MATCH->{capture} = (While->new( 'cond' => ${$MATCH->{'exp'}},'body' => ${$MATCH->{'exp_stmts'}}, ))) } || 1)))))))))))))) } }); $MATCH };
sub ctrl_leave { my $grammar = $_[0]; my $str = $_[1]; my $pos = $_[2]; my  $MATCH; ($MATCH = MiniPerl6::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, )); (($MATCH)->{bool} = do { (my  $pos1 = $MATCH->to()); do { ((('l' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && ((('e' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && ((('a' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && ((('v' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && ((('e' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && (do { ($MATCH->{capture} = (Leave->new(  ))) } || 1)))))) } }); $MATCH };
sub ctrl_return { my $grammar = $_[0]; my $str = $_[1]; my $pos = $_[2]; my  $MATCH; ($MATCH = MiniPerl6::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, )); (($MATCH)->{bool} = do { (my  $pos1 = $MATCH->to()); (do { ((('r' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && ((('e' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && ((('t' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && ((('u' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && ((('r' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && ((('n' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && (do { (my  $pos1 = $MATCH->to()); (do { do { (my  $tmp = $MATCH); ($MATCH = MiniPerl6::Match->new( 'str' => $str,'from' => $tmp->to(),'to' => $tmp->to(),'bool' => 1, )); (($MATCH)->{bool} = do { (my  $pos1 = $MATCH->to()); do { (('(' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) } }); (($tmp)->{bool} = ($MATCH ? 1 : 0)); ($MATCH = $tmp); ($MATCH ? 1 : 0) } } || do { (($MATCH)->{to} = $pos1); do { (my  $m2 = $grammar->ws($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());1 } else { 0 } } }) } && (do { (my  $m2 = $grammar->exp($str, $MATCH->to())); if ($m2) { (($MATCH)->{to} = $m2->to());($MATCH->{'exp'} = $m2);1 } else { 0 } } && (do { ($MATCH->{capture} = (Return->new( 'result' => ${$MATCH->{'exp'}}, ))) } || 1))))))))) } || do { (($MATCH)->{to} = $pos1); ((('r' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && ((('e' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && ((('t' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && ((('u' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && ((('r' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && ((('n' eq substr($str, $MATCH->to(), 1)) ? (1 + (($MATCH)->{to} = (1 + $MATCH->to()))) : 0) && (do { ($MATCH->{capture} = (Return->new( 'result' => Val::Undef->new(  ), ))) } || 1))))))) }) }); $MATCH }
}

1;
