use Test::More tests => 2;
use Test::Exception;

BEGIN {
	#----------------------------------------------------
    package My::Implementation;
    use Moose;

	#----------------------------------------------------
	# Factory class, all implementations valid
    package My::FactoryA;
    use MooseX::AbstractFactory;

	implementation_class_via sub { "My::Implementation" };

	sub _validate_implementation_class {
		return;
	}

	#----------------------------------------------------
	# Factory class, all implementations invalid
    package My::FactoryB;
    use MooseX::AbstractFactory;

	implementation_class_via sub { "My::Implementation" };

	sub _validate_implementation_class {
		confess "invalid implementation";
	}

}

my $imp;

lives_ok {
    $imp = My::FactoryA->create('Implementation',
                                {});
}
"FactoryA->new() doesn't die with Implementation";

dies_ok {
    $imp = My::FactoryB->create(
                               'Implementation',
                               {},
                              );
}
"FactoryB->new() dies with implementation";