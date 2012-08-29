#!perl

use Test::More tests => 1;

use MAD::Loader;

use FindBin;
use lib "$FindBin::Bin/lib";

MAD::Loader->new->load(qw{ Foo });

ok( defined Foo->can('init'), '"Foo" loaded' );
