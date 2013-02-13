#!perl

use strict;
use warnings;

use Test::More tests => 2;

use MAD::Loader;

my $loader;

$loader = MAD::Loader->new;
is_deeply( $loader->options, [], 'Default options are [ ]' );

my $options = [qw{foo bar etc 123}];
$loader = MAD::Loader->new( options => $options );
is_deeply( $loader->options, $options, 'Custom options ok' );
