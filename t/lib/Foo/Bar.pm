package Foo::Bar;

use strict;
use warnings;

my $baz;

sub init {
    my $class = shift;
    $Foo::Bar::baz = shift || 1;

    return $Foo::Bar::baz;
}

return 42;
