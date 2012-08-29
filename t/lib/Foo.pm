package Foo;

use strict;
use warnings;

my $bar;

sub init {
    my $class = shift;
    $Foo::bar = shift || 1;

    return $Foo::bar;
}

return 42;
