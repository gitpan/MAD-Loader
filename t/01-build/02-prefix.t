#!perl

use strict;
use warnings;

use Test::More tests => 3;
use Test::Exception;

use MAD::Loader;

my $loader;

$loader = MAD::Loader->new;
ok( $loader->prefix eq '', 'Default prefix is ""' );

$loader = MAD::Loader->new( prefix => 'Foo::Bar' );
ok( $loader->prefix eq 'Foo::Bar', 'Testing custom prefix' );

throws_ok { MAD::Loader->new( prefix => '123::456' ) }
  qr{Invalid prefix '123::456'}, 'Testing invalid prefix';
