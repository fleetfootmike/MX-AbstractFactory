# Load the Module::Install bundled in ./inc/
use inc::Module::Install;

# Define metadata
name            'MooseX-AbstractFactory';
all_from        'lib/MooseX/AbstractFactory.pm';

# Specific dependencies
requires       'Class::Load'     => 0;
requires       'Moose'           => 0;
requires       'Moose::Autobox'  => 0;
build_requires 'Test::Moose'     => 0;
build_requires 'Test::Exception' => 0;

use_test_base;
use_standard_tests;

auto_install;
WriteAll;
