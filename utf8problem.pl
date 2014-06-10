#!/usr/bin/env perl
use Mojolicious::Lite;
use Mojo::ByteStream 'b';
use Data::Dumper;

get '/japanese' => sub {
    my $self     = shift;
    my $filename = $self->app->home->rel_file('error.xml');

    warn "Reading $filename";

    my $strings;

    my $dom = Mojo::DOM->new( b($filename)->slurp->decode );

    foreach my $string ( $dom->find('*')->each ) {
        next if $string->type eq 'strings';
        $strings->{ $string->type } = $string->text;
    }

    $self->app->log->debug( Dumper($strings) );

    $self->render( json => $strings );

};

app->start;
