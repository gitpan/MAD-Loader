package MAD::Loader;

use strict;
use warnings;

use Moo;
use Carp;
use Const::Fast;

const my $MODULE_NAME_REGEX => qr{^[a-z_]\w*(::\w+)*$}i;

our $VERSION = '2.000002';

has prefix => (
    is  => 'ro',
    isa => sub {
        die "Invalid prefix '$_[0]'"
          unless $_[0] eq '' || $_[0] =~ $MODULE_NAME_REGEX;
    },
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

has set_inc => (
    is  => 'ro',
    isa => sub {
        die 'set_inc must be an ArrayRef or "undef"'
          unless !defined $_[0] || ref $_[0] eq 'ARRAY';
    },
    default => sub {
        return undef;
    },
);

has add_inc => (
    is  => 'ro',
    isa => sub {
        die 'add_inc must be an ArrayRef or "undef"'
          unless !defined $_[0] || ref $_[0] eq 'ARRAY';
    },
    default => sub {
        return undef;
    },
);

has inc => (
    is  => 'lazy',
    isa => sub {
        die 'inc must be an ArrayRef' unless ref $_[0] eq 'ARRAY';
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

has on_error => (
    is  => 'ro',
    isa => sub {
        die 'on_error must be an CodeRef' unless ref $_[0] eq 'CODE';
    },
    default => sub {
        return \&Carp::croak;
    },
);

sub load {
    my ( $self, @modules ) = @_;

    my $initializer = $self->initializer;
    my @options     = @{ $self->options };
    my $on_error    = $self->on_error;
    my $result      = {};

    local @INC = @{ $self->inc };

    foreach my $name (@modules) {
        my $module = $self->fully_qualified_name($name);

        my $error;
        {
            local $@;
            eval "use $module;";
            $error = $@;
        }

        if ($error) {
            $on_error->($error);
        }
        else {
            $result->{$name} =
                $module->can($initializer)
              ? $module->$initializer(@options)
              : undef;
        }
    }

    return $result;
}

sub fully_qualified_name {
    my $self = shift;
    my $name = shift || '';

    $name = $self->prefix . '::' . $name
      if $self->prefix;

    return $name =~ $MODULE_NAME_REGEX ? $name : '';
}

sub _build_inc {
    my ($self) = @_;

    my @inc = ();
    if ( defined $self->set_inc ) {
        push @inc, @{ $self->set_inc };
    }
    elsif ( defined $self->add_inc ) {
        push @inc, @{ $self->add_inc }, @INC;
    }
    else {
        push @inc, @INC;
    }

    return \@inc;
}

1;

=pod

=encoding utf8

=head1 NAME

MAD::Loader - A tiny module loader

=head1 VERSION

Version 2.0.2

=head1 SYNOPSIS

MAD::loader is a module loader for situations when you want several modules
being loaded dynamically.

For each module loaded this way an initializer method may be called with
custom arguments. You may also control where the loader will search for
modules, you may prefix the module names with a custom namespace and you
may change how it will behave on loading errors.

    use MAD::Loader;

    my $loader = MAD::Loader->new(
        prefix      => 'Foo',
        set_inc     => [ 'my/module/dir' ],
        initializer => 'new',
        options     => [ 123, 456 ],
        on_error    => \&error_handler,
    );
    
    my $res = $loader->load(qw{ Bar Baz });
    
    my $bar_obj = $res->{Bar};
    my $baz_obj = $res->{Baz};
    
    my $etc = Foo::Bar->new( 42, 13 );

In the example above, the loader will search for modules named 'Foo::Bar' and
'Foo::Baz' only within directory 'my/module/dir'. The coderef 'error_handler'
will be called for each module that fail to load. For each module found, the
method 'new' will be called with the array ( 123, 456 ) as argument. All
objects built this way will be returned within the hashref $res which has as
keys the module names provided to method 'load'.

=head1 METHODS

=head2 new( %params )

Creates a loader object.

You may provide any optional arguments: B<prefix>, B<initializer>,
B<options>, B<add_inc>, B<set_inc> and B<on_error>.

=head3 prefix

The namespace that will be prepended to the module names.

The default value is '' (empty string) meaning that no prefix will be used.

    my $loader = MAD::Loader->new( prefix => 'Foo' );
    $loader->load(qw{ Bar Etc 123 });
    
    ## This will load the modules:
    ##  * Foo::Bar
    ##  * Foo::Etc
    ##  * Foo::123

=head3 initializer

The name of the method used to initialize/instantiate the module.

The deault value is C<''> (empty string) meaning that no method will be
called.

When an C<initializer> is defined the loader will try to call it like as a
constructor passing the array C<options> as argument.

Note that the C<initializer> must be defined as a method of the module before
it can be called or it will be ignored.

The code below:

    my $loader = MAD::Loader->new(
        initializer => 'init',
        options     => [ 1, 2, 3 ],
    );
    $loader->load( 'Foo' );

Will cause something like this to occur:

    Foo->init( 1, 2, 3 )
        if Foo->can( 'init' );

=head3 options

An arrayref with the options provided to all initializers.

Note that although C<options> be an arrayref, it will be passed as an B<array>
to C<initializer>.

When several modules are loaded together, the same C<options> will be passed
to their initializers.

=head3 add_inc

An arrayref with directories to be prepended to C<@INC>.

The array C<@INC> will be localized before the loader add these directories,
so the original state of C<@INC> will be preserved out of the loader.

The default value is C<[]> meaning that original value of C<@INC> will be
used.

=head3 set_inc

An arrayref of directories used to override C<@INC>.

This option has priority over C<add_inc>, that is, if C<set_inc>
is defined the value of C<add_inc> will be ignored.

Again, C<@INC> will be localized internally so his original values will be
left untouched.

=head3 on_error

An error handler called when a module fails to load. His only argument will
be the exception thrown.

This is a coderef and the default value is C<Carp::croak>.

=head2 load( @modules )

Takes a list of module names and tries to load all of them in order.

For each module that fails to load, the error handler C<on_error> will be
called. Note that the default error handler is an alias to C<Carp::croak> so
in this case at the first fail, an exception will be thrown.

All module names will be prefixed with the provided C<prefix> and the loader
will try to make sure that they all are valid before try to load them. All
modules marked as "invalid" will not be loaded.

The term "invalid" is subject of discussion ahead.

The loader will search for modules into directories pointed by C<@INC> which
may be changed by attributes C<add_inc> and C<set_inc>.

If an C<initializer> was defined, it will be called for each module loaded,
receiving as argument the array provided by the attribute C<options>.

In the end, if no exception was thrown, the method C<load> will return a
hashref which the keys are the module names passed to it (without prefix)
and the values are whatever the C<initializer> returns.

=head2 prefix

Returns the namespace C<prefix> as described above.

=head2 initializer

Returns the name of the C<initializer> as described above.

=head2 options

Returns an arrayref with the C<options> provided to all initializers.

=head2 add_inc

Returns the arrayref of directories prepended to C<@INC>.

=head2 set_inc

Returns the arrayref of directories used to override C<@INC>.

=head2 inc

Returns the arrayref of directories that represents the content of C<@INC>
internally into the loader.

=head2 on_error

Returns the coderef of the error handler.

=head2 fully_qualified_name( $module )

This method is used to build the fully qualified name of a module.

When a namespace prefix is defined, it will be prepended to the module name.

If a fully qualified name cannot be found an empty string will be returned.

=head1 AUTHOR

Blabos de Blebe, C<< <blabos at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-mad-loader at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=MAD-Loader>. I will be
notified, and then you'll automatically be notified of progress on your bug
as I make changes.

=head1 LIMITATIONS

=head2 Valid Module Names

This module tries to define what is a valid module name. Arbitrarily we
consider a valid module name whatever module that matches with the regular
expression C<qr{^[a-z_]\w*(::\w+)*$}i>.

This validation is to avoid injection of arbitrarily code as fake module
names and the regular expression above should be changed in future versions
or a better approach may be considered.

Therefore some valid module names are considered invalid within
C<MAD::Loader> as names with UTF-8 characters for example. These modules
cannot be loaded by C<MAD::Loader> yet. For now this is intentional.

The old package delimiter C<'> (single quote) is intentionally ignored
in favor of C<::> (double colon). Modules with single quote as package
delimiter also cannot be loaded by C<MAD::Loader>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc MAD::Loader


You can also look for information at:

=over 4

=item * Github repository

L<https://github.com/blabos/MAD-Loader>

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

Estante Virtual L<http://estantevirtual.com.br>


=head1 LICENSE AND COPYRIGHT

Copyright 2013 Blabos de Blebe.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

