#!perl

use strict;
use warnings;

use Test::More tests => 2;

use MAD::Loader;

my $loader;

$loader = MAD::Loader->new;
ok( $loader->initializer eq '', 'Default initializer is ""' );

$loader = MAD::Loader->new( initializer => 'new' );
ok( $loader->initializer eq 'new', 'Custom initializer ok' );
