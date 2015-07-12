#!/usr/bin/perl -w

use warnings;
use strict;
use lib "../be/";
use Test::More;
use Classes::NodeDBIx::Schema;
use YAML::AppConfig;

#get config data
my $conf = YAML::AppConfig->new(file => "../conf/dbic.yaml");
my $db_conf = $conf->get("tree_manager_db");


sub run_tests {
    my ( $db ) = @_;

    ok $db->resultset('Node')->create( { pid => 9999}), 
        "Adding a row to the database seems to work.";

    is $db->resultset('Node')->find( { pid => 9999 } )->pid, 9999,
        "Looking up a row from the database seems to work.";

    ok $db->resultset('Node')->search( { pid => 9999 } )->delete,
        "Deleting a row from the database seems to work.";

    is $db->resultset('Node')->find( {pid => 9999 } ), undef,
        "It seems that a deleted row is actually deleted.";
}

ok my $db = Classes::NodeDBIx::Schema->connect(
    $db_conf->{dsn},
    $db_conf->{user},
    $db_conf->{password},
    {
        quote_names => $db_conf->{quote_names},
        mysql_enable_utf8 => $db_conf->{mysql_enable_utf8},
    }
), "Connection to database seems to work";

run_tests( $db );

done_testing;
