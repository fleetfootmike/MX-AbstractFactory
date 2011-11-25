package MooseX::AbstractFactory::Role;

use Moose::Autobox;
use Moose::Role;

our $VERSION = '0.3.2';
$VERSION = eval $VERSION;
our $AUTHORITY = 'cpan:PENFOLD';

has _options        => (is => 'ro', isa => 'HashRef');
has _implementation => (is => 'ro', isa => 'Str');

sub create {
    my ($class, $impl, $args) = @_;

    my $factory = $class->new(_implementation => $impl, _options => $args);

    my $i = $factory->_implementation();

    if (defined $impl) {
        my $iclass = $factory->_get_implementation_class($i);
        # pull in our implementation class
        $factory->_validate_implementation_class($iclass);

        eval "use $iclass";

        my $options = $factory->_options();

        my $implementation = $iclass->new($options);
        # TODO - should we sneak a factory attr onto the metaclass?
        return $implementation;
    }
    else {
        confess('No implementation provided');
    }
}

sub _get_implementation_class {
    my ($self, $impl) = @_;

    my $class = blessed $self;
    if ($self->meta->has_class_maker) {
        return $self->meta->implementation_class_maker->($impl);
    } 
    else {
        return $class . "::$impl";
    }
}

sub _validate_implementation_class {
    my ($self, $iclass) = @_;

    eval {
        # can we load the class?
        Class::MOP->load_class($iclass);    # may die if user really stuffed up _get_implementation_class()

        if ($self->meta->has_implementation_roles) {
            my $roles = $self->meta->implementation_roles();

            # create an anon class that's a subclass of it
            my $anon = Moose::Meta::Class->create_anon_class();

            # make it a subclass of the implementation
            $anon->superclasses($iclass);

            # Lifted from MooseX::Recipe::Builder->_build_anon_meta()

            # load our role classes
            $roles->map( sub { Class::MOP::load_class($_); } );

            # apply roles to anon class
            if (scalar @{$roles} == 1) {
                $roles->[0]->meta->apply($anon);
            }
            else {
                Moose::Meta::Role->combine($roles->map(sub { $_->meta; } ))->apply($anon);
            }
        }
    };
    confess "Invalid implementation class $iclass: $@" if $@;

    return;
}

1;
__END__

=head1 NAME

MooseX::AbstractFactory::Role - AbstractFactory behaviour as a Moose extension

=head1 SYNOPSIS

You shouldn't be using this on its own, but via MooseX::AbstractFactory

=head1 DESCRIPTION

Role to implement an AbstractFactory as a Moose extension.


=head1 SUBROUTINES/METHODS 

=head2 create()

Returns an instance of the requested implementation.

    use MooseX::AbstractFactory;
    
	my $imp = My::Factory->create(
		'Implementation',
		{ connection => 'Type1' },
	);
	
=head2 _validate_implementation_class()

Checks that the implementation class exists (via Class::MOP->load_class() ) 
to be used, and (optionally) that it provides the methods defined in _roles().

This can be overridden by a factory class definition if required: for example

	sub _validate_implementation_class {
		my $self = shift;
		return 1; # all implementation classes are valid :)
	}


=head2 _get_implementation_class()

By default, the factory figures out the class of the implementation requested 
by prepending the factory class itself, so for example

	my $imp = My::Factory->new(
		implementation => 'Implementation')
		
will return an object of class My::Factory::Implementation.

This can be overridden in the factory class by redefining the
_get_implementation_class() method, for example:
	
	sub _get_implementation_class {
		my ($self, $class) = @_;
		return "My::ImplementationClasses::$class";
	}

=head1 CONFIGURATION AND ENVIRONMENT
 
MooseX::AbstractFactory requires no configuration files or environment variables.


=head1 DEPENDENCIES

Moose, and Moose::Autobox


=head1 INCOMPATIBILITIES

None reported.


=head1 BUGS AND LIMITATIONS

No bugs have been reported. Yet.

Please report any bugs or feature requests to C<mike@altrion.org>, or via RT.


=head1 AUTHOR

Mike Whitaker  C<< <mike@altrion.org> >>

With thanks to Matt Trout for some of the ideas for the code in
_validate_implementation_class.


=head1 LICENSE AND COPYRIGHT

Copyright (c) 2007-8, Mike Whitaker C<< <mike@altrion.org> >>.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
