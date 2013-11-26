package HabitLab;
use strict;
use warnings;
use Dancer2;

our $VERSION = '0.1';


# Pass values from config to templates
hook 'before_template' => sub { 
    my $request = shift; 

    $request->{js_files} =  config->{js_files};
    $request->{css_files} =  config->{css_files};
    $request->{coffee_files} =  config->{coffee_files};
};

# Base folder (if the website is not running under '/' )
hook before_template_render => sub {
    my $tokens = shift;
    $tokens->{uri_base} = request->base->path;
};

### ROUTES
get '/' => sub {
    template 'index';
};

1;
