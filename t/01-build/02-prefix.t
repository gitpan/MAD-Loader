#!perl

use strict;
use warnings;

use Test::More tests => 3;

use MAD::Loader;

my $loader;

$loader = MAD::Loader->new;
ok( $loader->prefix eq '', 'Default prefix is ""' );

$loader = MAD::Loader->new( prefix => 'Foo::Bar' );
ok( $loader->prefix eq 'Foo::Bar', 'Testing custom prefix' );

eval { $loader = MAD::Loader->new( prefix => '123::456') };
pass 'Testing invalid prefix ' if $@;
