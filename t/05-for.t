use v6;

class Main {
    say '1..2';
    my @a := [ 1, 2 ];
    for @a -> $v {
        say 'ok ' ~ $v ~ ' - loop';
    }
}