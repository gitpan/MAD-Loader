#!perl

use strict;
use warnings;

use Test::More tests => 1;

use MAD::Loader;

eval { MAD::Loader->new->load('t/00-load.t') };
pass 'A filename cannot be loaded' if $@;
