use Test::More tests => 2;
use Test::Moose;
use Test::Exception;

BEGIN {
	package Bar::Implementation;
	use Moose;

	has connection => (is => 'ro', isa => 'Str');

	sub tweak { 1; };

	package My::Factory;
	use MooseX::AbstractFactory;

	sub _get_implementation_class {
		my ($self, $impl) = @_;

		return "Bar::" . $impl;
	}
}

my $imp;

lives_ok {
	$imp = My::Factory->create(
    	'Implementation',
    	{ connection => 'Type1' }
	);
} "Factory->new() doesn't die";

isa_ok($imp, "Bar::Implementation");
