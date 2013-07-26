use 5.016;
use strict;
use warnings FATAL => 'all';
use inc::Module::Install;

name 'MAD-Loader';
all_from 'lib/MAD/Loader.pm';
author q{Blabos de Blebe <blabos@cpan.org>};
license 'artistic';

perl_version 5.016;

tests_recursive('t');

resources(
    homepage   => 'http://blabos.org',
    license    => 'http://www.perlfoundation.org/artistic_license_1_0',
    repository => 'git://github.com/blabos/MAD-Loader.git',
    bugtracker => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=MAD-Loader',
);

configure_requires( 'Module::Install' => 0 );

build_requires( 'Test::Most' => 0.31 );

requires(
    'Moo'         => 1.003000,
    'Carp'        => 1.29,
    'Const::Fast' => 0.014,
);

install_as_cpan;
auto_install;
WriteAll;
