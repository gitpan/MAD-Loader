#!perl

use strict;
use warnings;

use Test::More tests => 5;

use MAD::Loader;

ok( !defined Foo::Etc->can('init'), '"Etc" not loaded' );
ok( !defined $Foo::Etc::foo, '"Etc" not initialized' );

my $loader = MAD::Loader->new(
    namespace   => 'Foo',
    inc_dirs    => ['t/lib'],
    no_import   => 1,
);

eval { $loader->load(qw{ Etc }) };

ok( Foo::Etc->can('init'),   '"Foo::Etc" was loaded' );
ok( Foo::Etc->can('import'), '"Foo::Etc" can import' );
ok( !defined $Foo::Etc::foo, '"Foo::Etc" was not initialized' );
