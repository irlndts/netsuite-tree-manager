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

#unique id
has 'cid' => ( 
        is => 'rw', 
        isa => 'Int',
        predicate => 'has_cid', 
    );

#############
###methods###
#############

sub writeNode {
    my $self = shift;
    my $db_connection = shift;

    $db_connection->write($self);

}



1;
