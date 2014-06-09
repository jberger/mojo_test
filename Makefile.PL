#!/usr/bin/env perl
use ExtUtils::MakeMaker;

WriteMakefile( PREREQ_PM => { 'Mojolicious' => '5.02', 'local::lib' => '0' } );
