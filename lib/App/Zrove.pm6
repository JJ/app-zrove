use v6.c;
unit class App::Zrove:ver<0.0.1>;

use Zef;
use Zef::CLI;

my &get-client = &Zef::CLI::get-client;
my &abort = &Zef::CLI::abort;
my &path2candidate = &Zef::CLI::path2candidate;

sub test(
    $CONFIG,
    $verbosity,
    Bool :force(:$force-test),
    Int  :timeout(:$test-timeout),
    *@paths ($, *@)
) {
    my $client = get-client(:config($CONFIG), :$force-test, :$test-timeout);
    my @candidates = $client.link-candidates( @paths.map(*.&path2candidate) );
    abort "Failed to resolve any candidates. No reason to proceed" unless +@candidates;
    my @tested = $client.test(@candidates);
    my (:@test-pass, :@test-fail) := @tested.classify: {.test-results.grep(*.so) ?? <test-pass> !! <test-fail> }
    
    say "!!!> Testing failed: {.as}{?($verbosity >= VERBOSE)??' at '~.dist.path!!''}" for @test-fail;
    
    exit ?@test-fail ?? 1 !! ?@test-pass ?? 0 !! 255;
}

=begin pod

=head1 NAME

App::Zrove - blah blah blah

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
