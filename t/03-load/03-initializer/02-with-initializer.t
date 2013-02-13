#!perl

use strict;
use warnings;

use Test::More tests => 2;

use MAD::Loader;

my $loader = MAD::Loader->new(
    set_inc     => ['t/lib'],
    initializer => 'init',
);

my $res = $loader->load('Foo');

ok( Foo::foo() == 1, 'Foo was initialized' );
is_deeply( $res, { 'Foo' => 42 }, 'Testing return value of Foo->init()' );
