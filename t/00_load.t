#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

package NotMain; # so Moose::Exporter doesn't complain

::use_ok('MooseX::AbstractFactory');
::use_ok('MooseX::AbstractFactory::Role');
::use_ok('MooseX::AbstractFactory::Meta::Class');