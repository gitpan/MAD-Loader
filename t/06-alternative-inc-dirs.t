#!perl

use Test::More tests => 5;

use MAD::Loader;

use FindBin;

ok( !defined Baz->can('init'), '"Baz" not loaded' );
ok( !defined $Baz::foo,        '"Baz" not initialized' );

my $loader = MAD::Loader->new(
    initializer => 'init',
    options     => [42],
    inc_dirs    => ["$FindBin::Bin/lib/Foo"],
);

$loader->load(qw{ Baz });

ok( defined Baz->can('init'), '"Baz" loaded' );
ok( defined $Baz::foo,        '"$Baz::foo" initialized' );
ok( $Baz::foo == 42,          '"$Baz::foo" correctly initialized' );
