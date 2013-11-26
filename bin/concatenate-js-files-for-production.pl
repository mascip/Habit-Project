#!/usr/bin/env perl 
use 5.16.3; # Perl version requirement
use feature ":5.16";
use strictures;

use Config::Any;
use IO::All;

# Debug
use Data::Printer;
use Carp::Always;

# The list of .coffee files comes from the development configuration, because they are not needed in production.
# The list of .js files to concatenate comes from the production configuration, because in development they are loaded locally, while in production I use CDNs for some.
my $dev_conf_file  = "environments/development.yml";
my $prod_conf_file = "environments/production.yml";
my $unique_js_file = 'public/app/production_application.js';
    # The resulting concatenated file, for production

# Extract configuration info
my $configs = Config::Any->load_files(
    { files => [$dev_conf_file, $prod_conf_file], use_ext => 1 });
my @coffee_files = @{ $configs->[0]->{$dev_conf_file}->{coffee_files} };
my @js_files = @{ $configs->[1]->{$prod_conf_file}->{js_files_to_concatenate} };

# Rename .coffee files to .js files
my @js_files_from_coffee = 
    map { s/\.coffee/\.js/; $_ }    # .js
    map { 'app/' . $_ }             # In the app/ directory
    @coffee_files; 

# All these files are in public/
my @all_js_files = map { 'public/' . $_ } (@js_files, @js_files_from_coffee);

# Concatenate all js files into one file, for production
my $io_concat = io($unique_js_file)->print("");     # empty the file
map { io($_)->slurp >> $io_concat } @all_js_files;  # append all js files content
