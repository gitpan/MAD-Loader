#!perl

use Test::More tests => 4;

use MAD::Loader;

ok( !defined Baz->can('init'), '"Baz" not loaded' );
ok( !defined $Baz::foo,        '"Baz" not initialized' );

my $loader = MAD::Loader->new(
    initializer => 'init',
    options     => [42],
);

eval { $loader->load(qw{ Baz }) };

ok( !defined Baz->can('init'), '"Baz" was not loaded yet' );
ok( !defined $Baz::foo,        '"Baz" wasc not initialized yet' );
