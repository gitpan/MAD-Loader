#!perl

use utf8;
use Test::Most;
use MAD::Loader qw{ load_module };

use lib 't/lib';

my $prefix     = 'Foo';
my $module     = 'Bar';
my $method     = 'foo';
my $fqn_module = "$prefix::$module";
my $result     = '';

ok( !$fqn_module->can($method), "$fqn_module is not loaded" );

$result = load_module( prefix => $prefix, module => $module, inc => \@INC );
is( $result, $fqn_module, "load_module returns '$fqn_module'" );

ok( $fqn_module->can($method), "$fqn_module is loaded" );

done_testing;
