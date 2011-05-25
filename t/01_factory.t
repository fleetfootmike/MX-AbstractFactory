use Test::More tests => 6;
use Test::Moose;
use Test::Exception;

BEGIN {
	package My::Factory::Implementation;
	use Moose;

	has connection => (is => 'ro', isa => 'Str');

	sub tweak { 1; };

	package My::Factory;
	use MooseX::AbstractFactory;
	use Moose;
}

my $imp;

lives_ok { 
	$imp = My::Factory->create(
    	'Implementation',
    	{ connection => 'Type1' }
	);
} "Factory->new() doesn't die";

isa_ok($imp, "My::Factory::Implementation");

can_ok($imp, qw/tweak/);
is($imp->tweak(),1,"tweak returns 1");
is($imp->connection(), 'Type1', 'connection attr set by constructor');

dies_ok {
	$imp->fudge();
} "fudge dies, not implemented on implementor";