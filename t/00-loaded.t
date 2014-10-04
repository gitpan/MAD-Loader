#!perl

use Test::Most;

my $module = 'Data::Dumper';
my $method = 'Dumper';
my $result = '';

if ( $module->can($method) ) {
    my $str = '';

    foreach my $key ( sort keys %INC ) {
        $str .= "$key => $INC{$key}\n";
    }

    $str .= $/ x 2;

    foreach my $key ( sort keys %main:: ) {
        $str .= "$key => $main::{$key}\n";
    }

    diag $str;
}

pass 'ok';
done_testing;

