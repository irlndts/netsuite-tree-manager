GRANT ALL PRIVILEGES ON netsuite_tree_manager.* TO manager@localhost identified by 'vj095crdf' with grant option;

drop table if exists nodes; 

create table nodes (
    id int auto_increment not null, -- node id
    pid int not null, -- parent id
    row int,
    constraint pk_uid primary key (id)
);

insert into nodes values (0,0,0);

DELIMITER ;;

DROP TRIGGER IF EXISTS add_row_to_node;;

CREATE TRIGGER add_row_to_node BEFORE INSERT ON nodes FOR each ROW   
BEGIN
	set NEW.row = 1 + (select row from nodes where id = NEW.pid limit 0,1);
END;;
DELIMITER ;;
