#!perl

use strict;
use warnings;

use Test::More tests => 1;

use MAD::Loader;

my $counter = 0;
my $handler = make_handler( \$counter );

my $loader = MAD::Loader->new(
    set_inc  => [],
    on_error => $handler,
);

$loader->load('Foo::Bar');
ok( $counter == 42, 'Testing custom error handler' );

sub make_handler {
    my $counter = shift;

    return sub {
        $$counter = 42;
    };
}
