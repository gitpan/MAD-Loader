requires 'perl' => '5.8.9';

requires 'Carp'        => '1.12';
requires 'Const::Fast' => '0.014';
requires 'Moo'         => '1.004006';

on 'test' => sub {
    requires 'File::Spec'         => '3.47';
    requires 'Scalar::Util'       => '1.38';
    requires 'Test::Most'         => '0.34';
    requires 'Test::Perl::Critic' => '1.02';
};

on 'configure' => sub {
    requires 'ExtUtils::MakeMaker' => '6.30';
};

on 'develop' => sub {
    requires 'Pod::Coverage::TrustPod' => '0.100003';
    requires 'Test::Pod'               => '1.41';
    requires 'Test::Pod::Coverage'     => '1.08';
};
