#!perl

use strict;
use warnings;

use Test::More tests => 1;

BEGIN {
    use_ok( 'MAD::Loader' ) || print "Bail out!\n";
}

diag( "Testing MAD::Loader $MAD::Loader::VERSION, Perl $], $^X" );
