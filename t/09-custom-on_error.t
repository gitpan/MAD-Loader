#!perl

use strict;
use warnings;

use Test::More tests => 5;

use MAD::Loader;

ok( !defined Baz->can('init'), '"Baz" not loaded' );
ok( !defined $Baz::foo, '"Baz" not initialized' );

my $code_ref = do_code();

my $loader = MAD::Loader->new(
    initializer => 'init',
    options     => [42],
    on_error    => $code_ref,
);

eval { $loader->load(qw{ Baz }) };

ok( !defined Baz->can('init'), '"Baz" was not loaded yet' );
ok( !defined $Baz::foo,        '"Baz" was not initialized yet' );
ok( $code_ref->() == 2,        'Custom code on error' );

sub do_code {
    my $var = 0;

    return sub {
        return ++$var;
    };
}
