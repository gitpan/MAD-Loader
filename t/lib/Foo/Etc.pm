package Foo::Etc;

use strict;
use warnings;

my $foo;

sub import {
    $Foo::Etc::foo = 13;
}

sub init {
    return $Foo::Etc::foo;
}

return 42;
