#!perl

use strict;
use warnings;

use Test::More tests => 4;

use MAD::Loader;

my ( $loader, @my_inc );

{
    local @INC = qw{ foo bar };
    $loader = MAD::Loader->new;
    is_deeply( $loader->inc, \@INC, 'Testing default inc dirs' );
}

{
    @my_inc = q{ foo bar etc };
    $loader = MAD::Loader->new( set_inc => \@my_inc );
    is_deeply( $loader->inc, \@my_inc, '"inc" with "set_inc"' );
}

{
    @my_inc = qw{ foo bar };
    local @INC = qw{ etc };
    my @expected = ( @my_inc, @INC );
    $loader = MAD::Loader->new( add_inc => \@my_inc );
    is_deeply( $loader->inc, \@expected, '"inc" with "add_inc"' );
}

{
    @my_inc = qw{ foo bar };
    local @INC = qw{ etc };
    $loader = MAD::Loader->new( add_inc => [123], set_inc => [456] );
    is_deeply( $loader->inc, [456], '"inc" with "add_inc" and "set_inc' );
}
