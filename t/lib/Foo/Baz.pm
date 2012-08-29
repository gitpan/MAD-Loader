package Baz;

use strict;
use warnings;

my $foo;

sub init {
    my $class = shift;
    $Baz::foo = shift || 1;

    return $Baz::foo;
}

return 42;
