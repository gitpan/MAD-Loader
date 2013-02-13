#!perl

use strict;
use warnings;

use Test::More tests => 5;

use MAD::Loader;

local @INC = ('/foo/bar');

my $loader;

$loader = MAD::Loader->new;

ok( !defined Foo->can('init'), 'Before load, Foo is not loaded' );

eval { $loader->load('Foo') };
pass 'Foo is not within @INC' if $@;

$loader = MAD::Loader->new( add_inc => ['t/lib'] );

$loader->load('Foo');
ok( defined Foo->can('init'), 'After load, Foo is loaded' );

is_deeply(
    $loader->inc,
    [ 't/lib', '/foo/bar' ],
    'Internal @INC of loader has "t/lib"'
);
is_deeply( \@INC, ['/foo/bar'], 'Global @INC is untouchable' );
