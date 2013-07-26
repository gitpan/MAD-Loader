#!perl

use Test::Most;
use MAD::Loader;

my ( $loader, $built );

$loader = MAD::Loader->new(
    prefix  => 'Foo::Bar',
    set_inc => ['t/lib'],
    builder => 'new',
);

$built = $loader->load_and_build( 1 .. 4 );

foreach my $module ( sort keys %{$built} ) {
    subtest "$module without args" => sub {
        my $object = $built->{$module};
        my $name = ( split m{::}, $module )[-1];

        isa_ok( $object, $module );
        can_ok( $object, 'foo' );
        is( $object->foo, $name, '$object->foo() eq ' . $name );
    };
}

$loader = MAD::Loader->new(
    prefix  => 'Foo::Bar',
    set_inc => ['t/lib'],
    builder => 'new',
    args    => [42],
);

$built = $loader->load_and_build( 1 .. 4 );

foreach my $module ( sort keys %{$built} ) {
    subtest "$module with args" => sub {
        my $object = $built->{$module};

        isa_ok( $object, $module );
        can_ok( $object, 'foo' );
        is( $object->foo, 42, '$object->foo() eq 42' );
    };
}

done_testing;
