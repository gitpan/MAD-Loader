#!perl

use strict;
use warnings;

use Test::More tests => 10;

use MAD::Loader;

my $loader = MAD::Loader->new;

ok( defined $loader, 'Loader instantiated' );
isa_ok( $loader, 'MAD::Loader' );
can_ok( $loader, 'initializer' );
can_ok( $loader, 'prefix' );
can_ok( $loader, 'options' );
can_ok( $loader, 'add_inc' );
can_ok( $loader, 'set_inc' );
can_ok( $loader, 'inc' );
can_ok( $loader, 'on_error' );
can_ok( $loader, 'fully_qualified_name' );
