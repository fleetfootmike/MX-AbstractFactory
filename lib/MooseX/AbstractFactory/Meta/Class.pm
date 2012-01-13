package MooseX::AbstractFactory::Meta::Class;
use Moose;
extends 'Moose::Meta::Class';

our $VERSION = '0.3.2';
$VERSION = eval $VERSION;
our $AUTHORITY = 'cpan:PENFOLD';

has implementation_roles => (
    isa => 'ArrayRef',
    is => 'rw',
    predicate => 'has_implementation_roles',
);

has implementation_class_maker => (
    isa => 'CodeRef',
    is => 'rw',
    predicate => 'has_class_maker',
);
1;

#ABSTRACT: Meta class for MooseX::AbstractFactory

=head1 SYNOPSIS

You shouldn't be using this on its own, but via MooseX::AbstractFactory

=head1 DESCRIPTION

Metaclass to implement an AbstractFactory as a Moose extension.

=method implementation_roles

Roles each implementation class must satisfy.

=method has_implementation_roles

Predicate for above

=method implementation_class_maker

Coderef to generate a full class from a tag in the factory create() method.

=method has_class_maker

Predicate for above

=head1 BUGS AND LIMITATIONS

No bugs have been reported. Yet.

Please report any bugs or feature requests to C<mike@altrion.org>, or via RT.

=cut
