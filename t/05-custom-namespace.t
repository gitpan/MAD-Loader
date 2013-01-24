#!perl

use strict;
use warnings;

use Test::More tests => 5;

use MAD::Loader;

use lib 't/lib';

ok( !defined Foo::Bar->can('init'), '"Foo::Bar" not loaded' );
ok( !defined $Foo::Bar::baz,        '"Foo::Bar" not initialized' );

my $loader = MAD::Loader->new(
    initializer => 'init',
    options     => [42],
    namespace   => 'Foo',
);

$loader->load(qw{ Bar });

ok( defined Foo::Bar->can('init'), '"Foo::Bar" loaded' );
ok( defined $Foo::Bar::baz,        '"$Foo::Bar::baz" initialized' );
ok( $Foo::Bar::baz == 42,          '"$Foo::Bar::baz" correctly initialized' );
