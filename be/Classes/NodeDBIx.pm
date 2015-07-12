package Classes::NodeDBIx;

use strict;
use Moose;
use YAML::AppConfig;
use Data::Dumper;

use Classes::NodeDBIx::Schema;

###############
###variables###
###############
#unique id
has 'connection' => ( 
        is => 'rw', 
        clearer => 'disconnect',
        predicate => 'is_connected', 
    );

#############
###methods###
#############

sub connect {
    my $self = shift;

    my $conf = YAML::AppConfig->new(file => "../conf/dbic.yaml");
    my $db_conf = $conf->get("tree_manager_db");

    $self->connection (Classes::NodeDBIx::Schema->connect(
        $db_conf->{dsn},
        $db_conf->{user},
        $db_conf->{password},
        {
            quote_names => $db_conf->{quote_names},
            mysql_enable_utf8 => $db_conf->{mysql_enable_utf8},
        }
        )
    );
}

sub read {
	my $self = shift;
    	$self->connect() unless $self->is_connected();
	my $rs = $self->connection->resultset('Node');	
	return ($rs->search(undef,{result_class => 'DBIx::Class::ResultClass::HashRefInflator'}));
}

sub write {
    my $self = shift;
    my $node = shift;

    $self->connect() unless $self->is_connected();
    return $self->connection->resultset('Node')->create({pid => $node->{pid}, cid => int(rand(100))});
}

1;
