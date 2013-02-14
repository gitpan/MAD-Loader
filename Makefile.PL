use 5.008008;
use strict;
use warnings FATAL => 'all';
use inc::Module::Install;

name 'MAD-Loader';
all_from 'lib/MAD/Loader.pm';
author q{Blabos de Blebe <blabos@cpan.org>};
license 'artistic';

perl_version 5.008008;

tests_recursive('t');

resources(
    homepage   => 'http://blabos.org',
    license    => 'http://www.perlfoundation.org/artistic_license_1_0',
    repository => 'git://github.com/blabos/MAD-Loader.git',
    bugtracker => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=MAD-Loader',
);

configure_requires( 'Module::Install' => 0 );

build_requires(
    'Test::More'      => 0,
    'Test::Exception' => 0,
);

requires(
    'Moo'         => 1.000008,
    'Carp'        => 0,
    'Const::Fast' => 0.013,
);

install_as_cpan;
auto_install;
WriteAll;
