#!perl

use strict;
use warnings;

use Test::More tests => 1;

use MAD::Loader;

my $loader = MAD::Loader->new(
    namespace   => 'Res',
    inc_dirs    => ['t/lib'],
    initializer => 'init',
);

my $res = $loader->load(qw{ Foo Bar Etc });

is_deeply(
    {
        Foo => 'foo',
        Bar => 'bar',
        Etc => 'etc',
    },
    $res,
    'Testing load return'
);
