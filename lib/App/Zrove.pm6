use v6.c;
unit class App::Zrove:ver<0.0.1>;

use Zef;
use Zef::CLI;

sub test(
    $CONFIG,
    $verbosity,
    Bool :force(:$force-test),
    Int  :timeout(:$test-timeout),
    *@paths ($, *@)
) {
    my $client = ZEF::CLI::get-client(:config($CONFIG), :$force-test, :$test-timeout);
#    my @candidates = $client.link-candidates( @paths.map(*.&ZEF::CLI::path2candidate) );
#    die "Failed to resolve any candidates. No reason to proceed" unless +@candidates;
#    my @tested = $client.test(@candidates);
#    my (:@test-pass, :@test-fail) := @tested.classify: {.test-results.grep(*.so) ?? <test-pass> !! <test-fail> }
    
#    say "!!!> Testing failed: {.as}{?($verbosity >= VERBOSE)??' at '~.dist.path!!''}" for @test-fail;
    
    #    return ?@test-fail ?? 1 !! ?@test-pass ?? 0 !! 255;
    return $client;
}

=begin pod

=head1 NAME

App::Zrove - Equivalent to prove, using Zef machinery.

=head1 SYNOPSIS

=begin code :lang<perl6>

use App::Zrove;

=end code

=head1 DESCRIPTION

App::Zrove is ...

=head1 AUTHOR

JJ Merelo <jjmerelo@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2019 JJ Merelo

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
