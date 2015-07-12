package Classes::Node;

use strict;
use Moose;

use Classes::NodeDBIx;

###############
###variables###
###############
#unique id
has 'id' => ( 
        is => 'rw', 
        isa => 'Int',
        predicate => 'has_id', 
    );

#parant id
has 'pid' => ( 
        is => 'rw', 
        isa => 'Int',
        predicate => 'has_pid', 
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
