use v6-alpha;

class Main {
    
    say '1..2';

    my $x := 0;
    if $x != 0 {
        print 'not '
    };
    say 'ok 1 - ', $x;

    my $x := 1;
    if $x != 1 {
        print 'not '
    };
    say 'ok 2 - ', $x;

}
