#!/usr/bin/perl -w

use strict;


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
