package HabitLab;
use strict;
use warnings;
use Dancer2;

our $VERSION = '0.1';

hook 'before_template' => sub { 
    my $request = shift; 

    # Pass values from config to templates
    $request->{js_files} =  config->{js_files};
    $request->{css_files} =  config->{css_files};
};

get '/' => sub {
    template 'index2';
};

1;
