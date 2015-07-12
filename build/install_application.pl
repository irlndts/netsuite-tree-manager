#!/usr/bin/perl -w

use strict;

my $num_args = $#ARGV + 1;
if ($num_args != 2) {
	print "\nUsage: sudo name.pl db_login db_password\n";
	exit;
}

my $db_login=$ARGV[0];
my $db_password=$ARGV[1];

my @libs = qw/
	"libyaml-appconfig-perl"
	"libdbix-class-schema-loader-perl"
	"libdbd-mysql-perl"
	"libplack-perl"
	"libanyevent-perl"
	"libhtml-template-perl"
	"mysql-server"
	"starman"
/;

foreach (@libs){
	system("apt-get install -y $_");
}

system ("mysql --password=$db_password -u db_login netsuite_tree_manager < ./db/tree_database.sql");
