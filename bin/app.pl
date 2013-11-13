#!/usr/bin/env perl

# General
use 5.14.1;    # Perl version requirement
use feature ":5.14";
use strictures;
use autodie qw( :all );

use FindBin;
use lib "$FindBin::Bin/../lib";

use IO::All;

use HabitLab;
use Plack::Builder;

builder {

    # Both in Production and Development
    
    # .coffee -> .js
    enable 'Compile' => (
        pattern => qr{\.coffee$},
        lib     => 'src/coffee',
        blib    => 'public/js',
        mime    => 'text/plain',
        map     => sub {
            my $filename = shift;
            $filename =~ s/coffee$/js/;
            say "    * COMPILED: $filename" if $ENV{env} eq 'dev';
            return $filename;
        },
        compile => sub {
            my ( $in, $out ) = @_;
            say "    * IN: $in, OUT: $out" if $ENV{env} eq 'dev';
            system("coffee --compile --stdio < $in > $out");
        }
    );

    # # .scss -> css
    # enable 'Compile' => (
    #     pattern => qr{\.scss$},
    #     lib     => 'src/sass',
    #     blib    => 'public/css',
    #     mime    => 'text/plain',
    #     map     => sub {
    #         my $filename = shift;
    #         $filename =~ s/scss$/css/;
    #         say "    * COMPILED: $filename" if $ENV{env} eq 'dev';
    #         return $filename;
    #     },
    #     compile => sub {
    #         my ( $in, $out ) = @_;
    #         say "    * IN: $in, OUT: $out" if $ENV{env} eq 'dev';
    #         system("compass compile");
    #     }
    # );

    # Minify and Concatenate JS and CSS files
    enable "Assets",
        files => [<public/js/**/*.js>];
    enable "Assets",
        files => [<public/css/**/*.css>],
        minify => 1; 
        # $env->{'psgix.assets'}->[0] points at the first asset.

    enable "Deflater",
        content_type => ['text/css','text/html','text/javascript','application/javascript'],
        vary_user_agent => 1;

        $ENV{env} = 'none';

    if ( $ENV{env} eq 'prod' ) {
        # Production

        # enable "Plack::Middleware::ServerStatus::Lite",
        #     path => '/server-status',
        #     allow => [ '127.0.0.1', '192.168.0.0/16' ],
        #     counter_file => '/tmp/counter_file',
        #     scoreboard => '/var/run/server'
        #     ;
    }
    else { 
        # Development
        
        enable 'Debug', panels =>
        [qw<DBITrace Memory Timer Parameters Dancer::Version Dancer::Settings>];

    }


    HabitLab->dance;
};
