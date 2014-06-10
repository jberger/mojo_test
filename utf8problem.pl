#!/usr/bin/perl
use Mojolicious::Lite;
use XML::LibXML;

get '/japanese' => sub {
    my $self     = shift;
    my $filename = $self->app->home->rel_file('error.xml');

    warn "Reading $filename";

    my $strings;

    my $dom = XML::LibXML->load_xml( location => $filename );

    foreach my $string ( $dom->findnodes('/strings/*') ) {
        $strings->{ $string->nodeName } = $string->textContent;
    }

    $self->render( json => $strings );

};

app->start;
