#!perl

use utf8;
use Test::Most;
use MAD::Loader qw{ load_module };

my $module = 'Data::Dumper';
my $method = 'Dumper';
my $result = '';

ok( !$module->can($method), "$module is not loaded" );

$result = load_module( module => $module, inc => \@INC );
is( $result, $module, "load_module returns '$module'" );

ok( $module->can($method), "$module is loaded" );

done_testing;
