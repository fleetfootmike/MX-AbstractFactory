use Test::More;

eval "use Test::Pod::Coverage 1.00";
plan skip_all => "Test::Pod::Coverage 1.00 required for testing POD coverage" if $@; 
eval "use Pod::Coverage::Moose";
plan skip_all => "Pod::Coverage::Moose required for testing POD coverage" if $@; 

all_pod_coverage_ok(
	{ trustme => [qr/^(new|.*meta)$/], 
	  coverage_class => 'Pod::Coverage::Moose',
  	}
);