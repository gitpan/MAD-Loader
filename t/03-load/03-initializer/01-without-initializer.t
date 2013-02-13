#!perl

use strict;
use warnings;

use Test::More tests => 1;

use MAD::Loader;

my $loader = MAD::Loader->new( set_inc => ['t/lib'] );

$loader->load('Foo');

ok( !defined Foo::foo(), 'Foo was not initialized' );
