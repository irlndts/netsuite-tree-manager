#!/usr/bin/perl -w

use Data::Dumper;
use YAML::AppConfig;
use Plack;
use Plack::Request;
use Plack::Response;
use Plack::Builder;
use Template;

use feature qw(say);
use strict;

#selfmade libraries
use Classes::Node;
use Classes::NodeDBIx;

#get configs
my $conf = YAML::AppConfig->new(file => "../conf/config.yaml");
my $db_conf = $conf->get("tree_manager_db");
my $t_config = $conf->get("template");

# database connect
my $db = Classes::NodeDBIx->new(
	dsn => $db_conf->{dsn},
	user=> $db_conf->{user},
	password => $db_conf->{password},
	quote_names => $db_conf->{quote_names},
	mysql_enable_utf8 => $db_conf->{mysql_enable_utf8}
);

#template config 
my $template = Template->new({
	START_TAG       => quotemeta($t_config->{start_tag}),
	END_TAG         => quotemeta($t_config->{end_tag}),
	INTERPOLATE     => $t_config->{interpolate},
	AUTO_RESET      => $t_config->{auto_reset},
	ERROR           => $t_config->{error},
	EVAL_PERL       => $t_config->{eval_perl},
	CACHE_SIZE      => $t_config->{cache_size},
	LOAD_PERL       => $t_config->{load_perl},
	RECURSION       => $t_config->{recursion},
	INCLUDE_PATH    => $t_config->{include_path},
	COMPILE_EXT     => $t_config->{compile_ext},
	COMPILE_DIR     => $t_config->{compile_dir},
}) || die ('Create template error: '.Template->error());


sub app { 
	my $location = shift;
	return sub {
		my $env = shift;
		my $req = Plack::Request->new($env);
		
		my %vars;
		my $result;
			
		#add new node for location write
		if (defined $location && $location eq 'write'){
			my $params = $req->parameters();
			if (defined $params->{pid} && $params->{pid} =~ /^\d+$/){
				my $node = Classes::Node->new(pid => $params->{pid});
				$result = $node->writeNode($db);
			}else {
				$result = 0;
			}
			$vars{error}.="Can't write the pid: $params->{pid}" unless $result;
		}
		#write location finish

		my @nodes = $db->read();
		
		#move nodes to hash
		my $h_nodes = undef;
		foreach my $node (@nodes){
			push(@{$h_nodes->{$node->{row}}->{$node->{pid}}} , $node->{id});
		}
			
		#show data to client
		foreach my $row (sort {$a <=> $b} keys %{$h_nodes}){
			$vars{body} .= "<tr><td>$row</td><td>";
			foreach my $pid (sort {$a <=> $b} keys %{$h_nodes->{$row}}){
				$vars{body} .= "<strong>–</strong> ";
				foreach my $id (sort {$a <=> $b} @{$h_nodes->{$row}->{$pid}}){
					$vars{body} .= "[P: $pid ID: $id] ";
				}
				$vars{body} .= " <strong>–</strong>";
			}
			$vars{body} .= "</td></tr>";
		}

		#show the result to screen
		my $out = undef;
		my $res = $req->new_response(200);
		$res->content_type('text/html');
		$template->process('index.tpl',\%vars,\$out) ? $res->body($out):$res->body($template->error);
		
		return $res->finalize();
	}
};

#cap for favicon.ico
my $favicon_app = sub {
	my $env    = shift;
	my $req = Plack::Request->new($env);
	my $res = $req->new_response(200);
	return $res->finalize();
};


# locations logic
my $main_app = builder {
	mount "/" => builder {app()};
	mount "/write" => builder {app('write')};
	mount "/favicon.ico" => builder {$favicon_app};
}

