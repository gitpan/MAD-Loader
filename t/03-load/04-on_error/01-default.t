#!perl

use strict;
use warnings;

use Test::More tests => 1;
use Test::Exception;

use MAD::Loader;

my $loader = MAD::Loader->new;

throws_ok { $loader->load('Foo::Bar') } qr{Can.t locate Foo/Bar.pm in .INC},
  'Carp::croak as default "on_error" behavior';
