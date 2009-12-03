# Do not edit this file - Generated by MiniPerl6
use v5;
use strict;
use MiniPerl6::Perl5::Runtime;
use MiniPerl6::Perl5::Match;
package MiniPerl6::Go::LexicalBlock;
sub new { shift; bless { @_ }, "MiniPerl6::Go::LexicalBlock" }
sub block { @_ == 1 ? ( $_[0]->{block} ) : ( $_[0]->{block} = $_[1] ) };
sub needs_return { @_ == 1 ? ( $_[0]->{needs_return} ) : ( $_[0]->{needs_return} = $_[1] ) };
sub top_level { @_ == 1 ? ( $_[0]->{top_level} ) : ( $_[0]->{top_level} = $_[1] ) };
sub emit { my $self = shift; my $List__ = \@_; do { [] }; do { if (@{$self->{block}}) {  } else { return('null') } }; (my  $str = ''); do { for my $decl ( @{$self->{block}} ) { do { if ((Main::isa($decl, 'Decl') && ($decl->decl() eq 'my'))) { ($str = ($str . ($decl->var()->emit() . ' := ')));do { if (($decl->var()->sigil() eq '%')) { ($str = ($str . 'new(Scalar).Bind( h_hash() );')) } else { do { if (($decl->var()->sigil() eq '@')) { ($str = ($str . 'new(Scalar).Bind( a_array() );')) } else { ($str = ($str . 'new(Scalar).Bind( u_undef );')) } } } } } else {  } };do { if ((Main::isa($decl, 'Bind') && (Main::isa($decl->parameters(), 'Decl') && ($decl->parameters()->decl() eq 'my')))) { ($str = ($str . ($decl->parameters()->var()->emit() . ' := new(Scalar);'))) } else {  } } } }; my  $last_statement; do { if ($self->{needs_return}) { ($last_statement = pop( @{$self->{block}} )) } else {  } }; do { for my $decl ( @{$self->{block}} ) { do { if ((Main::isa($decl, 'Decl') && ($decl->decl() eq 'my'))) {  } else { ($str = ($str . ($decl->emit() . ';'))) } } } }; do { if (($self->{needs_return} && $last_statement)) { do { if (Main::isa($last_statement, 'If')) { (my  $cond = $last_statement->cond());(my  $body = $last_statement->body());(my  $otherwise = $last_statement->otherwise());do { if ((Main::isa($cond, 'Apply') && ($cond->code() eq 'prefix:<!>'))) { ($cond = $cond->arguments()->[0]);($body = $last_statement->otherwise());($otherwise = $last_statement->body()) } else {  } };do { if ((Main::isa($cond, 'Var') && ($cond->sigil() eq '@'))) { ($cond = Apply->new( 'code' => 'prefix:<@>','arguments' => [$cond], )) } else {  } };($body = MiniPerl6::Go::LexicalBlock->new( 'block' => $body,'needs_return' => 1, ));($otherwise = MiniPerl6::Go::LexicalBlock->new( 'block' => $otherwise,'needs_return' => 1, ));($str = ($str . ('if ( (' . ($cond->emit() . (').Bool().b ) { ' . ($body->emit() . (' } else { ' . ($otherwise->emit() . ' }')))))))) } else { do { if ((Main::isa($last_statement, 'Return') || Main::isa($last_statement, 'For'))) { ($str = ($str . $last_statement->emit())) } else { do { if ($self->{top_level}) { ($str = ($str . ('Return( p, ' . ($last_statement->emit() . ')')))) } else { ($str = ($str . ('return(' . ($last_statement->emit() . ')')))) } } } } } } } else {  } }; do { if ($self->{top_level}) { ($str = ('
    p := make(chan Any);
    go func () { ' . ($str . '; return }();
    return <-p;
'))) } else {  } }; return($str) }


;
package CompUnit;
sub new { shift; bless { @_ }, "CompUnit" }
sub name { @_ == 1 ? ( $_[0]->{name} ) : ( $_[0]->{name} = $_[1] ) };
sub attributes { @_ == 1 ? ( $_[0]->{attributes} ) : ( $_[0]->{attributes} = $_[1] ) };
sub methods { @_ == 1 ? ( $_[0]->{methods} ) : ( $_[0]->{methods} = $_[1] ) };
sub body { @_ == 1 ? ( $_[0]->{body} ) : ( $_[0]->{body} = $_[1] ) };
sub emit { my $self = shift; my $List__ = \@_; do { [] }; (my  $class_name = Main::to_go_namespace($self->{name})); (my  $str = ('// instances of class ' . ($self->{name} . (Main->newline() . ('type ' . ($class_name . (' struct {' . Main->newline()))))))); do { for my $decl ( @{$self->{body}} ) { do { if ((Main::isa($decl, 'Decl') && ($decl->decl() eq 'has'))) { ($str = ($str . ('  ' . ('v_' . ($decl->var()->name() . (' Any;' . Main->newline())))))) } else {  } } } }; ($str = ($str . ('}' . Main->newline()))); (my  $str = ($str . ('// methods in class ' . ($self->{name} . (Main->newline() . ('var Method_' . ($class_name . (' struct {' . Main->newline())))))))); do { for my $decl ( @{$self->{body}} ) { do { if (Main::isa($decl, 'Method')) { ($str = ($str . ('  ' . ('f_' . ($decl->name() . (' func (*' . ($class_name . (', Capture) Any;' . Main->newline())))))))) } else {  } } } }; ($str = ($str . ('}' . Main->newline()))); (my  $str = ($str . ('// namespace ' . ($self->{name} . (Main->newline() . ('var Namespace_' . ($class_name . (' struct {' . Main->newline())))))))); do { for my $decl ( @{$self->{body}} ) { do { if (Main::isa($decl, 'Sub')) { ($str = ($str . ('  ' . ('f_' . ($decl->name() . (' Function;' . Main->newline())))))) } else {  } } } }; ($str = ($str . ('}' . Main->newline()))); (my  $str = ($str . ('// method wrappers for ' . ($self->{name} . Main->newline())))); do { for my $decl ( @{$self->{body}} ) { do { if (Main::isa($decl, 'Method')) { ($str = ($str . ('func (v_self *' . ($class_name . (') f_' . ($decl->name() . (' (v Capture) Any {' . (Main->newline() . ('  return Method_' . ($class_name . ('.f_' . ($decl->name() . ('(v_self, v);' . (Main->newline() . ('}' . Main->newline()))))))))))))))) } else {  } } } }; (my  $str = ($str . ('// prototype of ' . ($self->{name} . (Main->newline() . ('var Proto_' . ($class_name . (' ' . ($class_name . (';' . Main->newline())))))))))); do { if (($class_name eq 'Main')) { ($str = ($str . ('func main() {' . Main->newline()))) } else {  } }; ($str = ($str . ('    this_namespace := &Namespace_' . ($class_name . (';' . (Main->newline() . ('    this_namespace = this_namespace;' . Main->newline()))))))); do { for my $decl ( @{$self->{body}} ) { do { if ((Main::isa($decl, 'Decl') && ($decl->decl() eq 'my'))) { ($str = ($str . ($decl->var()->emit() . ' := ')));do { if (($decl->var()->sigil() eq '%')) { ($str = ($str . 'new(Scalar).Bind( h_hash() );')) } else { do { if (($decl->var()->sigil() eq '@')) { ($str = ($str . 'new(Scalar).Bind( a_array() );')) } else { ($str = ($str . 'new(Scalar).Bind( u_undef );')) } } } };($str = ($str . Main->newline())) } else {  } };do { if ((Main::isa($decl, 'Bind') && (Main::isa($decl->parameters(), 'Decl') && ($decl->parameters()->decl() eq 'my')))) { ($str = ($str . ($decl->parameters()->var()->emit() . (' := new(Scalar);' . Main->newline())))) } else {  } } } }; do { for my $decl ( @{$self->{body}} ) { do { if ((Main::isa($decl, 'Decl') && ($decl->decl() eq 'has'))) { ($str = ($str . ('  // accessor ' . ($decl->var()->name() . (Main->newline() . ('  ' . ($class_name . ('.f_' . ($decl->var()->name() . (' = Function{ f : func (v Capture) Any {' . (Main->newline() . ('    ' . ('return this.v_' . ($decl->var()->name() . (Main->newline() . ('  } };' . Main->newline())))))))))))))))) } else {  } };do { if (Main::isa($decl, 'Method')) { (my  $sig = $decl->sig());(my  $block = MiniPerl6::Go::LexicalBlock->new( 'block' => $decl->block(),'needs_return' => 1,'top_level' => 1, ));($str = ($str . ('  // method ' . ($decl->name() . (Main->newline() . ('  Method_' . ($class_name . ('.f_' . ($decl->name() . (' = func (v_self *' . ($class_name . (', v Capture) Any {' . (Main->newline() . ('    ' . ($sig->emit_bind() . (Main->newline() . ('    ' . ($block->emit() . (Main->newline() . ('  };' . Main->newline())))))))))))))))))))) } else {  } };do { if (Main::isa($decl, 'Sub')) { (my  $sig = $decl->sig());(my  $block = MiniPerl6::Go::LexicalBlock->new( 'block' => $decl->block(),'needs_return' => 1,'top_level' => 1, ));($str = ($str . ('  // sub ' . ($decl->name() . (Main->newline() . ('  Namespace_' . ($class_name . ('.f_' . ($decl->name() . (' = Function{ f : func (v Capture) Any {' . (Main->newline() . ('    ' . ($sig->emit_bind() . (Main->newline() . ('    ' . ($block->emit() . (Main->newline() . ('  } };' . Main->newline())))))))))))))))))) } else {  } } } }; do { for my $decl ( @{$self->{body}} ) { do { if ((((Main::isa($decl, 'Decl') && (($decl->decl() eq 'has') || ($decl->decl() eq 'my'))) ? 0 : 1) && ((Main::isa($decl, 'Method') ? 0 : 1) && (Main::isa($decl, 'Sub') ? 0 : 1)))) { ($str = ($str . ($decl->emit() . ';'))) } else {  } } } }; do { if (($class_name eq 'Main')) { ($str = ($str . ('}' . Main->newline()))) } else {  } } }


;
package Val::Int;
sub new { shift; bless { @_ }, "Val::Int" }
sub int { @_ == 1 ? ( $_[0]->{int} ) : ( $_[0]->{int} = $_[1] ) };
sub emit { my $self = shift; my $List__ = \@_; do { [] }; ('Int{i:' . ($self->{int} . '}')) }


;
package Val::Bit;
sub new { shift; bless { @_ }, "Val::Bit" }
sub bit { @_ == 1 ? ( $_[0]->{bit} ) : ( $_[0]->{bit} = $_[1] ) };
sub emit { my $self = shift; my $List__ = \@_; do { [] }; ('Bit{b:' . ($self->{bit} . '}')) }


;
package Val::Num;
sub new { shift; bless { @_ }, "Val::Num" }
sub num { @_ == 1 ? ( $_[0]->{num} ) : ( $_[0]->{num} = $_[1] ) };
sub emit { my $self = shift; my $List__ = \@_; do { [] }; ('Num{n:' . ($self->{num} . '}')) }


;
package Val::Buf;
sub new { shift; bless { @_ }, "Val::Buf" }
sub buf { @_ == 1 ? ( $_[0]->{buf} ) : ( $_[0]->{buf} = $_[1] ) };
sub emit { my $self = shift; my $List__ = \@_; do { [] }; ('Str{s:"' . (Main::lisp_escape_string($self->{buf}) . '"}')) }


;
package Val::Undef;
sub new { shift; bless { @_ }, "Val::Undef" }
sub emit { my $self = shift; my $List__ = \@_; do { [] }; 'u_undef' }


;
package Val::Object;
sub new { shift; bless { @_ }, "Val::Object" }
sub class { @_ == 1 ? ( $_[0]->{class} ) : ( $_[0]->{class} = $_[1] ) };
sub fields { @_ == 1 ? ( $_[0]->{fields} ) : ( $_[0]->{fields} = $_[1] ) };
sub emit { my $self = shift; my $List__ = \@_; do { [] }; die('Val::Object - not used yet') }


;
package Lit::Seq;
sub new { shift; bless { @_ }, "Lit::Seq" }
sub seq { @_ == 1 ? ( $_[0]->{seq} ) : ( $_[0]->{seq} = $_[1] ) };
sub emit { my $self = shift; my $List__ = \@_; do { [] }; ('[]Any{ ' . (Main::join([ map { $_->emit() } @{ $self->{seq} } ], ', ') . ' }')) }


;
package Lit::Array;
sub new { shift; bless { @_ }, "Lit::Array" }
sub array { @_ == 1 ? ( $_[0]->{array} ) : ( $_[0]->{array} = $_[1] ) };
sub emit { my $self = shift; my $List__ = \@_; do { [] }; (my  $str = ''); do { for my $item ( @{$self->{array}} ) { do { if (((Main::isa($item, 'Var') && ($item->sigil() eq '@')) || (Main::isa($item, 'Apply') && ($item->code() eq 'prefix:<@>')))) { ($str = ($str . ('func(a_) { ' . ('for i_ := 0; i_ < a_.length ; i_++ { a.Push(a_[i_]) }' . ('}(' . ($item->emit() . '); ')))))) } else { ($str = ($str . ('a.Push(' . ($item->emit() . '); ')))) } } } }; ('func () Array { ' . ('a := a_array(); ' . ($str . ('return a; ' . '}()')))) }


;
package Lit::Hash;
sub new { shift; bless { @_ }, "Lit::Hash" }
sub hash { @_ == 1 ? ( $_[0]->{hash} ) : ( $_[0]->{hash} = $_[1] ) };
sub emit { my $self = shift; my $List__ = \@_; do { [] }; (my  $fields = $self->{hash}); (my  $str = ''); do { for my $field ( @{$fields} ) { ($str = ($str . ('m[' . ($field->[0]->emit() . ('] = ' . ($field->[1]->emit() . '; ')))))) } }; ('func() map[string]Any { ' . ('var m = make(map[string]Any); ' . ($str . ('return m; ' . '}()')))) }


;
package Lit::Code;
sub new { shift; bless { @_ }, "Lit::Code" }
1


;
package Lit::Object;
sub new { shift; bless { @_ }, "Lit::Object" }
sub class { @_ == 1 ? ( $_[0]->{class} ) : ( $_[0]->{class} = $_[1] ) };
sub fields { @_ == 1 ? ( $_[0]->{fields} ) : ( $_[0]->{fields} = $_[1] ) };
sub emit { my $self = shift; my $List__ = \@_; do { [] }; (my  $fields = $self->{fields}); (my  $str = ''); do { for my $field ( @{$fields} ) { ($str = ($str . ('m.v_' . ($field->[0]->buf() . (' = ' . ($field->[1]->emit() . '; ')))))) } }; ('func() *' . (Main::to_go_namespace($self->{class}) . (' { ' . ('var m = new(' . (Main::to_go_namespace($self->{class}) . ('); ' . ($str . ('return m; ' . '}()')))))))) }


;
package Index;
sub new { shift; bless { @_ }, "Index" }
sub obj { @_ == 1 ? ( $_[0]->{obj} ) : ( $_[0]->{obj} = $_[1] ) };
sub index_exp { @_ == 1 ? ( $_[0]->{index_exp} ) : ( $_[0]->{index_exp} = $_[1] ) };
sub emit { my $self = shift; my $List__ = \@_; do { [] }; ($self->{obj}->emit() . ('.Array().Index(' . ($self->{index_exp}->emit() . ')'))) }


;
package Lookup;
sub new { shift; bless { @_ }, "Lookup" }
sub obj { @_ == 1 ? ( $_[0]->{obj} ) : ( $_[0]->{obj} = $_[1] ) };
sub index_exp { @_ == 1 ? ( $_[0]->{index_exp} ) : ( $_[0]->{index_exp} = $_[1] ) };
sub emit { my $self = shift; my $List__ = \@_; do { [] }; ($self->{obj}->emit() . ('.Hash().Lookup(' . ($self->{index_exp}->emit() . ')'))) }


;
package Var;
sub new { shift; bless { @_ }, "Var" }
sub sigil { @_ == 1 ? ( $_[0]->{sigil} ) : ( $_[0]->{sigil} = $_[1] ) };
sub twigil { @_ == 1 ? ( $_[0]->{twigil} ) : ( $_[0]->{twigil} = $_[1] ) };
sub namespace { @_ == 1 ? ( $_[0]->{namespace} ) : ( $_[0]->{namespace} = $_[1] ) };
sub name { @_ == 1 ? ( $_[0]->{name} ) : ( $_[0]->{name} = $_[1] ) };
sub emit { my $self = shift; my $List__ = \@_; do { [] }; (my  $table = { '$' => 'v_','@' => 'List_','%' => 'Hash_','&' => 'Code_', }); (my  $ns = ''); do { if ($self->{namespace}) { ($ns = (Main::to_go_namespace($self->{namespace}) . '.')) } else {  } }; (($self->{twigil} eq '.') ? ('this.v_' . ($self->{name} . '')) : (($self->{name} eq '/') ? ($table->{$self->{sigil}} . 'MATCH') : ($table->{$self->{sigil}} . ($ns . $self->{name})))) };
sub plain_name { my $self = shift; my $List__ = \@_; do { [] }; do { if ($self->{namespace}) { return(($self->{namespace} . ('.' . $self->{name}))) } else {  } }; return($self->{name}) }


;
package Bind;
sub new { shift; bless { @_ }, "Bind" }
sub parameters { @_ == 1 ? ( $_[0]->{parameters} ) : ( $_[0]->{parameters} = $_[1] ) };
sub arguments { @_ == 1 ? ( $_[0]->{arguments} ) : ( $_[0]->{arguments} = $_[1] ) };
sub emit { my $self = shift; my $List__ = \@_; do { [] }; do { if (Main::isa($self->{parameters}, 'Lit::Array')) { (my  $a = $self->{parameters}->array());(my  $str = ('func () Any { ' . ('List_tmp := ' . ($self->{arguments}->emit() . '; '))));(my  $i = 0);do { for my $var ( @{$a} ) { (my  $bind = Bind->new( 'parameters' => $var,'arguments' => Index->new( 'obj' => Var->new( 'sigil' => '@','twigil' => '','namespace' => '','name' => 'tmp', ),'index_exp' => Val::Int->new( 'int' => $i, ), ), ));($str = ($str . (' ' . ($bind->emit() . '; '))));($i = ($i + 1)) } };return(($str . ' return List_tmp }()')) } else {  } }; do { if (Main::isa($self->{parameters}, 'Lit::Hash')) { (my  $a = $self->{parameters}->hash());(my  $b = $self->{arguments}->hash());(my  $str = 'do { ');(my  $i = 0);my  $arg;do { for my $var ( @{$a} ) { ($arg = Val::Undef->new(  ));do { for my $var2 ( @{$b} ) { do { if (($var2->[0]->buf() eq $var->[0]->buf())) { ($arg = $var2->[1]) } else {  } } } };(my  $bind = Bind->new( 'parameters' => $var->[1],'arguments' => $arg, ));($str = ($str . (' ' . ($bind->emit() . '; '))));($i = ($i + 1)) } };return(($str . ($self->{parameters}->emit() . ' }'))) } else {  } }; do { if (Main::isa($self->{parameters}, 'Lit::Object')) { (my  $class = $self->{parameters}->class());(my  $a = $self->{parameters}->fields());(my  $b = $self->{arguments});(my  $str = 'do { ');(my  $i = 0);my  $arg;do { for my $var ( @{$a} ) { (my  $bind = Bind->new( 'parameters' => $var->[1],'arguments' => Call->new( 'invocant' => $b,'method' => $var->[0]->buf(),'arguments' => [],'hyper' => 0, ), ));($str = ($str . (' ' . ($bind->emit() . '; '))));($i = ($i + 1)) } };return(($str . ($self->{parameters}->emit() . ' }'))) } else {  } }; do { if (Main::isa($self->{parameters}, 'Call')) { return(('func () Any { ' . ('tmp := ' . ($self->{arguments}->emit() . ('; ' . ($self->{parameters}->invocant()->emit() . ('.v_' . ($self->{parameters}->method() . (' = tmp; ' . ('return tmp; ' . '}()')))))))))) } else {  } }; ($self->{parameters}->emit() . ('.Bind( ' . ($self->{arguments}->emit() . ' )'))) }


;
package Proto;
sub new { shift; bless { @_ }, "Proto" }
sub name { @_ == 1 ? ( $_[0]->{name} ) : ( $_[0]->{name} = $_[1] ) };
sub emit { my $self = shift; my $List__ = \@_; do { [] }; Main::to_go_namespace($self->{name}) }


;
package Call;
sub new { shift; bless { @_ }, "Call" }
sub invocant { @_ == 1 ? ( $_[0]->{invocant} ) : ( $_[0]->{invocant} = $_[1] ) };
sub hyper { @_ == 1 ? ( $_[0]->{hyper} ) : ( $_[0]->{hyper} = $_[1] ) };
sub method { @_ == 1 ? ( $_[0]->{method} ) : ( $_[0]->{method} = $_[1] ) };
sub arguments { @_ == 1 ? ( $_[0]->{arguments} ) : ( $_[0]->{arguments} = $_[1] ) };
sub emit { my $self = shift; my $List__ = \@_; do { [] }; (my  $invocant = $self->{invocant}->emit()); do { if (Main::isa($self->{invocant}, 'Proto')) { ($invocant = ('Proto_' . $invocant)) } else {  } }; do { if (($self->{method} eq 'values')) { do { if ($self->{hyper}) { die('not implemented') } else { return(('@{' . ($invocant . '}'))) } } } else {  } }; do { if ((($self->{method} eq 'perl') || (($self->{method} eq 'isa') || ($self->{method} eq 'scalar')))) { do { if ($self->{hyper}) { return(('(func (a_) { ' . ('var out = []; ' . ('if ( typeof a_ == \'undefined\' ) { return out }; ' . ('for(var i = 0; i < a_.length; i++) { ' . ('out.Push( f_' . ($self->{method} . ('(a_[i]) ) } return out;' . (' })(' . ($invocant . ')')))))))))) } else {  } };return(('f_' . ($self->{method} . ('(' . ($invocant . (($self->{arguments} ? (', ' . Main::join([ map { $_->emit() } @{ $self->{arguments} } ], ', ')) : '') . ')')))))) } else {  } }; do { if (($self->{method} eq 'join')) { return(($invocant . ('.' . ($self->{method} . ('(' . (Main::join([ map { $_->emit() } @{ $self->{arguments} } ], ', ') . ')')))))) } else {  } }; do { if ((($self->{method} eq 'yaml') || (($self->{method} eq 'say') || ($self->{method} eq 'chars')))) { do { if ($self->{hyper}) { return(('(func (a_) { ' . ('var out = []; ' . ('if ( typeof a_ == \'undefined\' ) { return out }; ' . ('for(var i = 0; i < a_.length; i++) { ' . ('out.Push( Main.' . ($self->{method} . ('(a_[i]) ) } return out;' . (' })(' . ($invocant . ')')))))))))) } else { do { if (defined($self->{arguments})) { return(('Main.' . ($self->{method} . ('(' . ($invocant . (', ' . (Main::join([ map { $_->emit() } @{ $self->{arguments} } ], ', ') . ')'))))))) } else { return(('Main.' . ($self->{method} . ('(' . ($invocant . ')'))))) } } } } } else {  } }; (my  $meth = $self->{method}); do { if (($meth eq 'postcircumfix:<( )>')) { do { if ($self->{hyper}) { ($meth = '') } else { return(($invocant . ('.Apply( Capture{ p : []Any{ ' . (Main::join([ map { $_->emit() } @{ $self->{arguments} } ], ', ') . ' } } )')))) } } } else {  } }; do { if ($self->{hyper}) { ('(func (a_) { ' . ('var out = []; ' . ('if ( typeof a_ == \'undefined\' ) { return out }; ' . ('for(var i = 0; i < a_.length; i++) { ' . ('out.Push( a_[i].f_' . ($meth . ('() ) } return out;' . (' })(' . ($invocant . ')'))))))))) } else { ($invocant . ('.f_' . ($meth . ('( Capture{ p : []Any{ ' . (Main::join([ map { $_->emit() } @{ $self->{arguments} } ], ', ') . ' } } )'))))) } } }


;
package Apply;
sub new { shift; bless { @_ }, "Apply" }
sub code { @_ == 1 ? ( $_[0]->{code} ) : ( $_[0]->{code} = $_[1] ) };
sub arguments { @_ == 1 ? ( $_[0]->{arguments} ) : ( $_[0]->{arguments} = $_[1] ) };
sub namespace { @_ == 1 ? ( $_[0]->{namespace} ) : ( $_[0]->{namespace} = $_[1] ) };
sub emit { my $self = shift; my $List__ = \@_; do { [] }; (my  $code = $self->{code}); do { if (Main::isa($code, 'Str')) {  } else { return(('(' . ($self->{code}->emit() . (')->(' . (Main::join([ map { $_->emit() } @{ $self->{arguments} } ], ', ') . ')'))))) } }; do { if (($code eq 'self')) { return('this') } else {  } }; do { if (($code eq 'false')) { return('b_false') } else {  } }; do { if (($code eq 'make')) { return(('func () Any { ' . ('tmp := ' . (Main::join([ map { $_->emit() } @{ $self->{arguments} } ], ', ') . ('; ' . ('v_MATCH.v_capture = tmp; ' . ('return tmp; ' . '}()'))))))) } else {  } }; do { if (($code eq 'say')) { return(('Print( Capture{ p : []Any{ ' . (Main::join([ map { $_->emit() } @{ $self->{arguments} } ], ', ') . ', Str{s:"\\n"} } } )'))) } else {  } }; do { if (($code eq 'print')) { return(('Print( Capture{ p : []Any{ ' . (Main::join([ map { $_->emit() } @{ $self->{arguments} } ], ', ') . ' } } )'))) } else {  } }; do { if (($code eq 'warn')) { return(('Print_stderr( Capture{ p : []Any{ ' . (Main::join([ map { $_->emit() } @{ $self->{arguments} } ], ', ') . ', Str{s:"\\n"} } } )'))) } else {  } }; do { if (($code eq 'defined')) { return(('(' . (Main::join([ map { $_->emit() } @{ $self->{arguments} } ], ' ') . ' != null)'))) } else {  } }; do { if (($code eq 'substr')) { return(('(' . ($self->{arguments}->[0]->emit() . (').substr(' . ($self->{arguments}->[1]->emit() . (', ' . ($self->{arguments}->[2]->emit() . ')'))))))) } else {  } }; do { if (($code eq 'prefix:<~>')) { return(('(' . (Main::join([ map { $_->emit() } @{ $self->{arguments} } ], ' ') . ').Str()'))) } else {  } }; do { if (($code eq 'prefix:<!>')) { return(('(' . (Main::join([ map { $_->emit() } @{ $self->{arguments} } ], ' ') . ').Bool().Not()'))) } else {  } }; do { if (($code eq 'prefix:<?>')) { return(('(' . (Main::join([ map { $_->emit() } @{ $self->{arguments} } ], ' ') . ').Bool()'))) } else {  } }; do { if (($code eq 'prefix:<$>')) { return(('f_scalar(' . (Main::join([ map { $_->emit() } @{ $self->{arguments} } ], ' ') . ')'))) } else {  } }; do { if (($code eq 'prefix:<@>')) { return(('(' . (Main::join([ map { $_->emit() } @{ $self->{arguments} } ], ' ') . ')'))) } else {  } }; do { if (($code eq 'prefix:<%>')) { return(('(' . (Main::join([ map { $_->emit() } @{ $self->{arguments} } ], ' ') . ').f_hash()'))) } else {  } }; do { if (($code eq 'infix:<~>')) { return(('Str{ s: strings.Join( []string{' . ('(' . ($self->{arguments}->[0]->emit() . (').Str().s, ' . ('(' . ($self->{arguments}->[1]->emit() . (').Str().s' . '}, "" ) }')))))))) } else {  } }; do { if (($code eq 'infix:<+>')) { return(('Int{ i:' . ('(' . ($self->{arguments}->[0]->emit() . (').Int().i + ' . ('(' . ($self->{arguments}->[1]->emit() . (').Int().i ' . '}')))))))) } else {  } }; do { if (($code eq 'infix:<->')) { return(('Int{ i:' . ('(' . ($self->{arguments}->[0]->emit() . (').Int().i - ' . ('(' . ($self->{arguments}->[1]->emit() . (').Int().i ' . '}')))))))) } else {  } }; do { if (($code eq 'infix:<>>')) { return(('Bool{ b:' . ('(' . ($self->{arguments}->[0]->emit() . (').Int().i > ' . ('(' . ($self->{arguments}->[1]->emit() . (').Int().i ' . '}')))))))) } else {  } }; do { if (($code eq 'infix:<&&>')) { return(('( (' . ($self->{arguments}->[0]->emit() . (').Bool()' . (' && (' . ($self->{arguments}->[1]->emit() . ').Bool() )')))))) } else {  } }; do { if (($code eq 'infix:<||>')) { return(('( (' . ($self->{arguments}->[0]->emit() . (').Bool()' . (' || (' . ($self->{arguments}->[1]->emit() . ').Bool() )')))))) } else {  } }; do { if (($code eq 'infix:<eq>')) { return(('(' . ($self->{arguments}->[0]->emit() . (').Str().Str_equal(' . ($self->{arguments}->[1]->emit() . ')'))))) } else {  } }; do { if (($code eq 'infix:<ne>')) { return(('(' . ($self->{arguments}->[0]->emit() . (').Str().Str_equal(' . ($self->{arguments}->[1]->emit() . ').Not()'))))) } else {  } }; do { if (($code eq 'infix:<==>')) { return(('(' . ($self->{arguments}->[0]->emit() . (').Equal(' . ($self->{arguments}->[1]->emit() . ')'))))) } else {  } }; do { if (($code eq 'infix:<!=>')) { return(('(' . ($self->{arguments}->[0]->emit() . (').Equal(' . ($self->{arguments}->[1]->emit() . ').Not()'))))) } else {  } }; do { if (($code eq 'ternary:<?? !!>')) { return(('func () Any { ' . ('if (' . ($self->{arguments}->[0]->emit() . (').Bool().b ' . ('{ return ' . ($self->{arguments}->[1]->emit() . (' }; ' . ('return ' . ($self->{arguments}->[2]->emit() . (' ' . '}()'))))))))))) } else {  } }; ($code = ('f_' . $self->{code})); do { if ($self->{namespace}) { ($code = ('Namespace_' . (Main::to_go_namespace($self->{namespace}) . ('.' . $code)))) } else { ($code = ('this_namespace.' . $code)) } }; ($code . ('.Apply( Capture{ p : []Any{ ' . (Main::join([ map { $_->emit() } @{ $self->{arguments} } ], ', ') . ' } } )'))) }


;
package Return;
sub new { shift; bless { @_ }, "Return" }
sub result { @_ == 1 ? ( $_[0]->{result} ) : ( $_[0]->{result} = $_[1] ) };
sub emit { my $self = shift; my $List__ = \@_; do { [] }; return(('Return( p, ' . ($self->{result}->emit() . ')'))) }


;
package If;
sub new { shift; bless { @_ }, "If" }
sub cond { @_ == 1 ? ( $_[0]->{cond} ) : ( $_[0]->{cond} = $_[1] ) };
sub body { @_ == 1 ? ( $_[0]->{body} ) : ( $_[0]->{body} = $_[1] ) };
sub otherwise { @_ == 1 ? ( $_[0]->{otherwise} ) : ( $_[0]->{otherwise} = $_[1] ) };
sub emit { my $self = shift; my $List__ = \@_; do { [] }; (my  $cond = $self->{cond}); do { if ((Main::isa($cond, 'Apply') && ($cond->code() eq 'prefix:<!>'))) { (my  $if = If->new( 'cond' => $cond->arguments()->[0],'body' => $self->{otherwise},'otherwise' => $self->{body}, ));return($if->emit()) } else {  } }; do { if ((Main::isa($cond, 'Var') && ($cond->sigil() eq '@'))) { ($cond = Apply->new( 'code' => 'prefix:<@>','arguments' => [$cond], )) } else {  } }; ('if ( (' . ($cond->emit() . (').Bool().b ) { ' . (Main::join([ map { $_->emit() } @{ $self->{body} } ], ';') . (' } else { ' . (Main::join([ map { $_->emit() } @{ $self->{otherwise} } ], ';') . ' }')))))) }


;
package For;
sub new { shift; bless { @_ }, "For" }
sub cond { @_ == 1 ? ( $_[0]->{cond} ) : ( $_[0]->{cond} = $_[1] ) };
sub body { @_ == 1 ? ( $_[0]->{body} ) : ( $_[0]->{body} = $_[1] ) };
sub topic { @_ == 1 ? ( $_[0]->{topic} ) : ( $_[0]->{topic} = $_[1] ) };
sub emit { my $self = shift; my $List__ = \@_; do { [] }; ('func (a_ Any) { for i_ := 0; i_ < len(a_); i_++ { ' . ('func (' . ($self->{topic}->emit() . (' Any) { ' . (Main::join([ map { $_->emit() } @{ $self->{body} } ], ';') . (' }(a_[i_]) } }' . ('(' . ($self->{cond}->emit() . ')')))))))) }


;
package Decl;
sub new { shift; bless { @_ }, "Decl" }
sub decl { @_ == 1 ? ( $_[0]->{decl} ) : ( $_[0]->{decl} = $_[1] ) };
sub type { @_ == 1 ? ( $_[0]->{type} ) : ( $_[0]->{type} = $_[1] ) };
sub var { @_ == 1 ? ( $_[0]->{var} ) : ( $_[0]->{var} = $_[1] ) };
sub emit { my $self = shift; my $List__ = \@_; do { [] }; $self->{var}->emit() }


;
package Sig;
sub new { shift; bless { @_ }, "Sig" }
sub invocant { @_ == 1 ? ( $_[0]->{invocant} ) : ( $_[0]->{invocant} = $_[1] ) };
sub positional { @_ == 1 ? ( $_[0]->{positional} ) : ( $_[0]->{positional} = $_[1] ) };
sub named { @_ == 1 ? ( $_[0]->{named} ) : ( $_[0]->{named} = $_[1] ) };
sub emit { my $self = shift; my $List__ = \@_; do { [] }; ' print \'Signature - TODO\'; die \'Signature - TODO\'; ' };
sub emit_bind { my $self = shift; my $List__ = \@_; do { [] }; (my  $str = ''); (my  $i = 0); do { for my $decl ( @{$self->{positional}} ) { ($str = ($str . ($decl->emit() . (' := v.p[' . ($i . ']; ')))));($i = ($i + 1)) } }; return($str) }


;
package Method;
sub new { shift; bless { @_ }, "Method" }
sub name { @_ == 1 ? ( $_[0]->{name} ) : ( $_[0]->{name} = $_[1] ) };
sub sig { @_ == 1 ? ( $_[0]->{sig} ) : ( $_[0]->{sig} = $_[1] ) };
sub block { @_ == 1 ? ( $_[0]->{block} ) : ( $_[0]->{block} = $_[1] ) };
sub emit { my $self = shift; my $List__ = \@_; do { [] }; (my  $invocant = $self->{sig}->invocant()); ('func ' . ($self->{name} . ('(v Capture) Any { ' . ('    ' . ($self->{sig}->emit_bind() . (Main->newline() . ('    ' . (MiniPerl6::Go::LexicalBlock->new( 'block' => $self->{block},'needs_return' => 1,'top_level' => 1, )->emit() . ' }')))))))) }


;
package Sub;
sub new { shift; bless { @_ }, "Sub" }
sub name { @_ == 1 ? ( $_[0]->{name} ) : ( $_[0]->{name} = $_[1] ) };
sub sig { @_ == 1 ? ( $_[0]->{sig} ) : ( $_[0]->{sig} = $_[1] ) };
sub block { @_ == 1 ? ( $_[0]->{block} ) : ( $_[0]->{block} = $_[1] ) };
sub emit { my $self = shift; my $List__ = \@_; do { [] }; do { if (($self->{name} eq '')) { return(('Function{ f: func(v Capture) Any { ' . ('    ' . ($self->{sig}->emit_bind() . (Main->newline() . ('    ' . (MiniPerl6::Go::LexicalBlock->new( 'block' => $self->{block},'needs_return' => 1,'top_level' => 1, )->emit() . ('} ' . '}')))))))) } else {  } }; ('func ' . ($self->{name} . ('(v Capture) Any { ' . ('    ' . ($self->{sig}->emit_bind() . (Main->newline() . ('    ' . (MiniPerl6::Go::LexicalBlock->new( 'block' => $self->{block},'needs_return' => 1,'top_level' => 1, )->emit() . ' }')))))))) }


;
package Do;
sub new { shift; bless { @_ }, "Do" }
sub block { @_ == 1 ? ( $_[0]->{block} ) : ( $_[0]->{block} = $_[1] ) };
sub emit { my $self = shift; my $List__ = \@_; do { [] }; ('(func () Any { ' . (MiniPerl6::Go::LexicalBlock->new( 'block' => $self->{block},'needs_return' => 1, )->emit() . ('; return u_undef ' . '})()'))) }


;
package Use;
sub new { shift; bless { @_ }, "Use" }
sub mod { @_ == 1 ? ( $_[0]->{mod} ) : ( $_[0]->{mod} = $_[1] ) };
sub emit { my $self = shift; my $List__ = \@_; do { [] }; ('// use ' . ($self->{mod} . Main->newline())) }


;
1;
