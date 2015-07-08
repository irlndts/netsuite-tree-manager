drop table if exists nodes; 

create table nodes (
    u_id int not null, -- unique node id
    pid    int, -- parent id
    id   int not null, -- current node id
    constraint pk_pid primary key (pid)
)
