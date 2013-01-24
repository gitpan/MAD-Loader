#!perl

use strict;
use warnings;

use Test::More tests => 5;

use MAD::Loader;

use lib 't/lib';

ok( !defined Baz->can('init'), '"Baz" not loaded' );
ok( !defined $Baz::foo, '"Baz" not initialized' );

my $loader = MAD::Loader->new(
    initializer => 'init',
    options     => [42],
    inc_dirs    => ['t/lib/Foo'],
);

$loader->load(qw{ Baz });

ok( defined Baz->can('init'), '"Baz" loaded' );
ok( defined $Baz::foo,        '"$Baz::foo" initialized' );
ok( $Baz::foo == 42,          '"$Baz::foo" correctly initialized' );
