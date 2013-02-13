#!perl

use strict;
use warnings;

use Test::More tests => 2;

use MAD::Loader;

my $loader = MAD::Loader->new(
    set_inc     => ['t/lib'],
    initializer => 'init',
    options     => [13],
);

my $res = $loader->load('Foo');

ok( Foo::foo() == 13, 'Foo was initialized with options');
is_deeply( $res, { 'Foo' => 42 }, 'Testing return value of Foo->init()' );
