#!perl

use strict;
use warnings;

use Test::More tests => 2;

use MAD::Loader;

my $loader = MAD::Loader->new;

ok(
    !defined Data::Dumper->can('Dumper'),
    'Before load, Data::Dumper is not loaded'
);

$loader->load('Data::Dumper');

ok( Data::Dumper->can('Dumper'), 'After load, Data::Dumper is loaded' );
