#!/usr/bin/perl -w

use Data::Dumper;
use YAML::AppConfig;

use feature qw(say);
use strict;

#and...  selfmade libraries
use Classes::Node;
use Classes::NodeDBIx;


my $node = Classes::Node->new(pid => "1", cid => "1");
my $db = Classes::NodeDBIx->new;
$db->write($node);

=cut
my $nodes = $db->resultset('Node')->search( { pid => 0});

while(my $node = $nodes->next) {
    print $node->pid."\n";
    print $node->uid."\n";
}
