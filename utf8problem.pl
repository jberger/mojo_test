#!/usr/bin/perl
use Mojolicious::Lite;
use Mojo::JSON;
use Mojo::Util qw(slurp);

get '/japanese' => sub {
    my $self     = shift;
    my $filename = $self->app->home->rel_file('error.xml');
    say "Reading $filename";

    my $strings;
    my $dom = Mojo::DOM->new( slurp($filename) );

    foreach my $string ( $dom->find('*')->each ) {
        next if $string->type eq 'strings';
        $strings->{ $string->type } = $string->text;
    }

    $self->render( json => $strings );

};

app->start;
