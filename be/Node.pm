package Node;

use strict;
use Moose;

#parant id
has 'pid' => ( 
        is => 'rw', 
        isa => 'Int'
    );

#self id
has 'id' => ( 
        is => 'rw', 
        isa => 'Int'
    );

1;
