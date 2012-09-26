package MAD::Loader;

use strict;
use warnings;

use Moo;
use Carp;

our $VERSION = '0.000003';

has namespace => (
    is      => 'ro',
    default => sub {
        return '';
    }
);

has initializer => (
    is      => 'ro',
    default => sub {
        return '';
    }
);

has inc_dirs => (
    is  => 'ro',
    isa => sub {
        die 'inc_dirs must be an ArrayRef' unless ref $_[0] eq 'ARRAY';
    },
    default => sub {
        return [];
    },
);

has options => (
    is  => 'ro',
    isa => sub {
        die 'options must be an ArrayRef' unless ref $_[0] eq 'ARRAY';
    },
    default => sub {
        return [];
    },
);

sub load {
    my ( $self, @modules ) = @_;

    my $namespace   = $self->namespace;
    my $initializer = $self->initializer;
    my @inc_dirs    = ( @INC, @{ $self->inc_dirs } );
    my @options     = @{ $self->options };

    $namespace .= '::' if $namespace;
    
    local @INC = @inc_dirs;

    foreach my $module ( map { $namespace . $_ } @modules ) {
        eval "require $module;";
        Carp::croak $@ if $@;

        $module->import if $module->can('import');
        $module->$initializer(@options) if $module->can($initializer);
    }
}

return 42;

__END__

=head1 NAME

MAD::Loader - The MAD module Loader

=head1 VERSION

Version 0.0.3

=cut

=head1 SYNOPSIS

Loads and optionally initializes modules

    use MAD::Loader;

    my $loader = MAD::Loader->new;
    $loader->load(qw{Foo::Bar});
    
    my $foobar = Foo::Bar->new;

=head1 METHODS

=head2 new

Creates a loader object.

You may provide any optional arguments: B<inc_dirs>, B<initializer>,
B<namespace> and B<options>.

See more details about them in documentation of their respective accessors.

=cut

=head2 load

Takes a list of module names and tries to load all of them in order. If
anyone fails to load, an exception is thrown.

=cut

=head2 inc_dirs

Returns the value of B<inc_dirs>.

The B<inc_dirs> attribute is a list of directories in addition to the ones
present in @INC in which the MAD::Loader will search for the modules passed
to method B<load>.

The method B<load> will properly localize the array @INC, so the original
content is maintained intact when it returns.

=cut

=head2 initializer

Returns the value of B<initializer>.

The B<initializer> attribute is a string with the name of the method that
will be used to initialize the module.

=cut

=head2 namespace

Returns the namespace where look for modules.

The B<namespace> atribute will be prefixed to the names of the modules
before loading them.

=cut

=head2 options

Returns the value of B<options>.

The B<options> attribute is a list o parameters that will be passed to the
B<initializer> method.

=cut

=head1 AUTHOR

Blabos de Blebe, C<< <blabos at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-mad-loader at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=MAD-Loader>. I will be
notified, and then you'll automatically be notified of progress on your bug
as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc MAD::Loader


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=MAD-Loader>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/MAD-Loader>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/MAD-Loader>

=item * Search CPAN

L<http://search.cpan.org/dist/MAD-Loader/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2012 Blabos de Blebe.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut
