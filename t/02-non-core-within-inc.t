#!perl

use strict;
use warnings;

use Test::More tests => 1;

use MAD::Loader;

use lib 't/lib';

MAD::Loader->new->load(qw{ Foo });

ok( defined Foo->can('init'), '"Foo" loaded' );
