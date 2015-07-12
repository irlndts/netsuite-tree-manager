#!/usr/bin/perl -w

use Data::Dumper;
use YAML::AppConfig;
use Plack;
use Plack::Request;
use Plack::Response;
use Plack::Builder;
use AnyEvent;

use feature qw(say);
use strict;

#selfmade libraries
use Classes::Node;
use Classes::NodeDBIx;


my $db = Classes::NodeDBIx->new;

sub app { 
	my $location = shift;
	return sub {
		my $env = shift;
		my $req = Plack::Request->new($env);
		
		my $body;
		my $result;
			
		#add new node
		if (defined $location && $location eq 'write'){
			my $params = $req->parameters();
			if (defined $params->{pid} && $params->{pid} ne ''){
				my $node = Classes::Node->new(pid => $params->{pid});
				$result = $node->writeNode($db);
			}else {
				$body.="Can't write the pid\n";
				$result = 0;
			}
		}

		my @nodes = $db->read();

		foreach my $node (@nodes){
			$body .= "ROW: ".$node->{row}." UID: ".$node->{uid}." PID: ".$node->{pid}." CID: ".$node->{cid}."\n";
		}

		my $res = $req->new_response(200);
		$res->body($body);
		return $res->finalize();
	}
};



my $main_app = builder {
	mount "/" => builder {app()};
	mount "/write" => builder {app('write')};
}


=cut

my $node = Classes::Node->new(pid => "1", cid => "1");
my $db = Classes::NodeDBIx->new;
$db->write($node);

my $nodes = $db->resultset('Node')->search( { pid => 0});

while(my $node = $nodes->next) {
    print $node->pid."\n";
    print $node->uid."\n";
}
