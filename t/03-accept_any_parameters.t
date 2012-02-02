use strict;
use warnings;
use Test::More;
use Test::Exception;
{
	package My::Connection;
	use Moose;
	
	has type => (
		is => 'ro',
		isa => 'Str',
		default => sub { 'Type1' },
		lazy => 1,
	);
}

{
	package My::Factory::Implementation;
	use Moose;

	around BUILDARGS => sub {
		my ( $orig, $self, $conn ) = @_;

		$self->$orig({ connection => $conn->type });
	};

	has connection => (is => 'ro', isa => 'Str');

	sub tweak { 1; };
}

{
	package My::Factory;
	use MooseX::AbstractFactory;
	use Moose;
}

my $connection = My::Connection->new;

my $imp;
lives_ok {
	$imp = My::Factory->create(
    	'Implementation',
		$connection
	);
} "Factory->new() doesn't die";

isa_ok($imp, "My::Factory::Implementation");

can_ok($imp, qw/tweak/);
is($imp->tweak(),1,"tweak returns 1");
is($imp->connection(), 'Type1', 'connection attr set by constructor');

dies_ok {
	$imp->fudge();
} "fudge dies, not implemented on implementor";

done_testing;
