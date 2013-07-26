package Foo::Bar::4;

use Moo;

has 'foo' => (
    is      => 'ro',
    default => sub { ( split m{::}, __PACKAGE__ )[-1] },
);

sub BUILDARGS {
    my ( $class, @args ) = @_;

    unshift @args, 'foo' if @args;
    return {@args};
}

1;
