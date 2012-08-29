#!perl

use Test::More tests => 5;

use MAD::Loader;

use FindBin;
use lib "$FindBin::Bin/lib";

ok( !defined Foo->can('init'), '"Foo" not loaded' );
ok( !defined $Foo::bar,        '"Foo" not initialized' );

my $loader = MAD::Loader->new( initializer => 'init' );

$loader->load(qw{ Foo });

ok( defined Foo->can('init'), '"Foo" loaded' );
ok( defined $Foo::bar,        '"$Foo::bar" initialized' );
ok( $Foo::bar == 1,           '"$Foo::bar" correctly initialized' );
