#!perl

use strict;
use warnings;

use Test::More tests => 1;
use Test::Exception;

use MAD::Loader;

throws_ok { MAD::Loader->new->load('t/00-load.t') } qr{syntax error at},
  'A filename cannot be loaded';
