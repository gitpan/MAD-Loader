#!perl

use strict;
use warnings;

use Test::More tests => 2;

use lib 't/lib';

use MAD::Loader;

my $loader = MAD::Loader->new;

ok( !defined Foo->can('init'), 'Before load, Foo is not loaded' );

$loader->load('Foo');

ok( defined Foo->can('init'), 'After load, Foo is loaded' );
