#!/usr/bin/perl
use Mojolicious::Lite;
use Mojo::ByteStream 'b';
use XML::LibXML;

get '/japanese' => sub {
    my $self     = shift;
    my $filename = $self->app->home->rel_file('error.xml');
    say "Reading $filename";

    my $strings;

    #my $dom = Mojo::DOM->new( b($filename)->slurp->decode );
    my $dom = XML::LibXML->load_xml( location => $filename );

    # foreach my $string ( $dom->find('*')->each ) {
    #     next if $string->type eq 'strings';
    #     $strings->{ $string->type } = $string->text;
    # }
    foreach my $string ( $dom->findnodes('/strings/*') ) {
        $strings->{ $string->nodeName } = $string->textContent;
    }

    $self->render( json => $strings );

};

app->start;
