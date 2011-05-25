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
__END__

=head1 NAME

MooseX::AbstractFactory::Meta::Class - Meta class for MooseX::AbstractFactory

=head1 SYNOPSIS

You shouldn't be using this on its own, but via MooseX::AbstractFactory

=head1 DESCRIPTION

Metaclass to implement an AbstractFactory as a Moose extension.

=head1 SUBROUTINES/METHODS 

=head2 implementation_roles

Roles each implementation class must satisfy.

=head2 has_implementation_roles

Predicate for above

=head2 implementation_class_maker

Coderef to generate a full class from a tag in the factory create() method.

=head2 has_class_maker

Predicate for above

=head1 CONFIGURATION AND ENVIRONMENT
 
MooseX::AbstractFactory requires no configuration files or environment variables.


=head1 DEPENDENCIES

Moose.


=head1 INCOMPATIBILITIES

None reported.


=head1 BUGS AND LIMITATIONS

No bugs have been reported. Yet.

Please report any bugs or feature requests to C<mike@altrion.org>, or via RT.


=head1 AUTHOR

Mike Whitaker  C<< <mike@altrion.org> >>


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
