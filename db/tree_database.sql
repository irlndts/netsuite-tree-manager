GRANT ALL PRIVILEGES ON netsuite_tree_manager.* TO piskun@localhost identified by 'vj095crdf' with grant option;

drop table if exists nodes; 

create table nodes (
    uid int auto_increment not null, -- unique node id
    pid int not null, -- parent id
    cid int not null, -- current node id
    constraint pk_uid primary key (uid),
    key k_pid (pid),
    key k_cid (cid)
)
