use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'MAD::Loader',
    AUTHOR        => q{Blabos de Blebe <blabos@cpan.org>},
    VERSION_FROM  => 'lib/MAD/Loader.pm',
    ABSTRACT_FROM => 'lib/MAD/Loader.pm',
    ( $ExtUtils::MakeMaker::VERSION >= 6.3002
        ? ( 'LICENSE' => 'perl' )
        : () ),
    PL_FILES  => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'Carp'       => 0,
        'Moo'        => 0,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES    => 'MAD-Loader-*' },
);
