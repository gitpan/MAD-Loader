#!perl

use strict;
use warnings;

use Test::More tests => 1;

use MAD::Loader;

my $loader = MAD::Loader->new;

eval { $loader->load('Foo::Bar') };
pass 'Carp::croak as default "on_error" behavior' if $@;
