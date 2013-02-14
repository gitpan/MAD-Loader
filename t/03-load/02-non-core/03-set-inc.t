#!perl

use strict;
use warnings;

use Test::More tests => 5;
use Test::Exception;

use MAD::Loader;

local @INC = ('/foo/bar');

my $loader;

$loader = MAD::Loader->new;

ok( !defined Foo->can('init'), 'Before load, Foo is not loaded' );

throws_ok { $loader->load('Foo') } qr{Can.t locate Foo.pm in .INC},
  'Foo is not within @INC';

$loader = MAD::Loader->new( set_inc => ['t/lib'] );

$loader->load('Foo');
ok( defined Foo->can('init'), 'After load, Foo is loaded' );

is_deeply( $loader->inc, ['t/lib'], 'Internal @INC of loader has "t/lib"' );
is_deeply( \@INC, ['/foo/bar'], 'Global @INC is untouchable' );
