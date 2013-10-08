#!/usr/bin/env perl

# General
use 5.16.3;    # Perl version requirement
use feature ":5.16";
use strictures;
use autodie qw( :all );

use FindBin;
use lib "$FindBin::Bin/../lib";

use IO::All;

use HabitLab;
use Plack::Builder;

builder {
    enable 'Debug', panels =>
      [qw<DBITrace Memory Timer Parameters Dancer::Version Dancer::Settings>];

    enable 'Compile' => (
        pattern => qr{\.coffee$},
        lib     => 'public/coffee',
        blib    => 'public/coffee/js-from-coffee',
        mime    => 'text/plain',
        map     => sub {
            my $filename = shift;
            $filename =~ s/coffee$/js/;
            say "    * FILE: $filename";
            return $filename;
        },
        compile => sub {
            my ( $in, $out ) = @_;
            say "    * IN: $in, OUT: $out";

            #system("coffee --compile --map -o public/coffee $in");
            system("coffee --compile --map --stdio < $in > $out");
        }
    );

    HabitLab->dance;
};
