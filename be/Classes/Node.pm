package Classes::Node;

use strict;
use Moose;
use YAML::AppConfig;

use Classes::NodeDBIx;

###############
###variables###
###############
#unique id
has 'uid' => ( 
        is => 'rw', 
        isa => 'Int',
        predicate => 'has_uid', 
    );

#parant id
has 'pid' => ( 
        is => 'rw', 
        isa => 'Int',
        predicate => 'has_pid', 
    );

#current id
has 'cid' => ( 
        is => 'rw', 
        isa => 'Int',
        predicate => 'has_cid', 
    );

#row of the node
has 'row' => ( 
        is => 'rw', 
        isa => 'Int',
        predicate => 'has_row', 
    );

#############
###methods###
#############

sub is_defined {
	my $self = shift;
	return 0 if (!defined $self->{pid} || $self->{pid} eq '');
	return 1;
}

sub writeNode {
	my $self = shift;
	my $db_connection = shift;
	return 0 unless $self->is_defined();
	return $db_connection->write($self);
}

1;
