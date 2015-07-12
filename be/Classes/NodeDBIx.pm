package Classes::NodeDBIx;

use strict;
use Moose;
use YAML::AppConfig;
use Data::Dumper;
use feature qw/say/;

use Classes::NodeDBIx::Schema;

###############
###variables###
#unique id
has 'connection' => ( 
        is => 'rw', 
        clearer => 'disconnect',
        predicate => 'is_connected', 
    );

has 'dsn' => ( 
	is => 'rw', 
     );

has 'user' => ( 
	is => 'rw', 
      );

has 'password' => ( 
	is => 'rw', 
	);

has 'quote_names' => ( 
	is => 'rw', 
	);

has 'mysql_enable_utf8' => ( 
	is => 'rw', 
	);

#############
###methods###

sub connect {
    my $self = shift;

    $self->connection (Classes::NodeDBIx::Schema->connect(
        $self->{dsn},
        $self->{user},
        $self->{password},
        {
            quote_names => $self->{quote_names},
            mysql_enable_utf8 => $self->{mysql_enable_utf8},
        }
        )
    );
}

sub read {
	my $self = shift;
    	$self->connect() unless $self->is_connected();
	my $rs = $self->connection->resultset('Node');	
	return ($rs->search(undef,{
				order_by => {-asc => [qw/row/]},
				result_class => 'DBIx::Class::ResultClass::HashRefInflator'}
			   ));
}

sub write {
	my $self = shift;
	my $node = shift;

	$self->connect() unless $self->is_connected();
	if (defined $self->connection->resultset('Node')->find( { id => $node->{pid} })){
		$self->connection->resultset('Node')->create({pid => $node->{pid}});
	}else {
		return 0;
	}
	return 1;
}

1;
