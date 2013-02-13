#!perl

use strict;
use warnings;

use Test::More tests => 8;

use MAD::Loader;

use Carp;
use Scalar::Util qw{refaddr};

my ( $loader, $code );

$loader = MAD::Loader->new;
$code   = $loader->on_error;

ok( defined $code, 'Default "on_error"defined' );
ok( ref $code eq 'CODE', 'Default "on_error" is a coderef' );
ok(
    refaddr($code) == refaddr( \&Carp::croak ),
    'Default "on_error" is "Carp::croak"'
);

$loader = MAD::Loader->new( on_error => \&my_sub );
$code   = $loader->on_error;

ok( defined $code, 'Custom "on_error"defined' );
ok( ref $code eq 'CODE', 'Custom "on_error" is a coderef' );
ok( refaddr($code) == refaddr( \&my_sub ), 'Default "on_error" is "my_sub"' );
ok( $code->() == 42, 'Custom "on_error" returns 42' );

ok(
    refaddr( \&my_sub ) != refaddr( \&Carp::croak ),
    "refaddr( my_sub ) != refaddr( Carp::croak )"
);

sub my_sub { 42 }
