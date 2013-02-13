#!perl

use strict;
use warnings;

use Test::More tests => 1;

use MAD::Loader;

my $res = MAD::Loader->new->load;
is_deeply( $res, {}, '"load" without args' );
