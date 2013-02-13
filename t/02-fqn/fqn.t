#!perl

use strict;
use warnings;

use Test::More tests => 7;

use MAD::Loader;

my $loader;

$loader = MAD::Loader->new;

is( $loader->fully_qualified_name(), '', 'Undefined module name' );

is(
    $loader->fully_qualified_name('Foo::Bar::Etc::123'),
    'Foo::Bar::Etc::123', 'Valid module name without prefix',
);

is(
    $loader->fully_qualified_name('1Foo::Bar::Etc::123'),
    '', 'Invalid module name without prefix',
);

$loader = MAD::Loader->new( prefix => 'Test' );

is(
    $loader->fully_qualified_name('Foo::Bar::Etc::123'),
    'Test::Foo::Bar::Etc::123', 'Valid module name with prefix',
);

is(
    $loader->fully_qualified_name('123::Foo::Bar::Etc::456'),
    'Test::123::Foo::Bar::Etc::456',
    'Invalid module name with prefix',
);

is(
    $loader->fully_qualified_name('Foo::☃'),
    '', 'Module names with UTF-8 characters are not supported',
);

is(
    $loader->fully_qualified_name('/tmp/foo.pl'),
    '', 'A filename cannot be a module name',
);
