#!perl

use Test::More tests => 2;

use MAD::Loader;

ok( !defined Data::Dumper->can('Dumper'), '"Data::Dumper" not loaded' );

MAD::Loader->new->load(q{Data::Dumper});

ok( defined Data::Dumper->can('Dumper'), '"Data::Dumper" loaded' );
