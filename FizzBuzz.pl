#!/usr/bin/perl
#
# This is part of a code test designed to test basic skills
# This is not "production code" or code related to any functional projects.

# Strict and warnings are recommended.
use strict;
use warnings;
use DBI;

use Data::Dumper;

my $driver   = "SQLite"; 
my $database = "fizzbuzz_database.db";
my $dsn = "DBI:$driver:dbname=$database";
my $userid = "";
my $password = "";
my $dbh = DBI->connect( $dsn, $userid, $password, { RaiseError => 1 } ) or die $DBI::errstr;

print "Connected to Database, reading table 'users'!\n\n";

#database connection has been established

#create query as variable
my $stmt = qq(SELECT firstName, lastName, home FROM users WHERE id >= ? AND id < ?);

#prepare arguments for possible pagination
my $sth = $dbh->prepare($stmt);
$sth->execute(1, 10);

while (my $row = $sth->fetchrow_hashref) {
	my $firstName = $row->{firstName};
	my $lastName = $row->{lastName} ? $row->{lastName} : "N/A";
	my $home = $row->{home} ? $row->{home} : "N/A";

	print qq($firstName\t\t$lastName\t\t$home\n);
   	#print "\nfname: $row->{firstName}\tlname: $row->{lastName}\thome: $row->{home}\n";
}

print "\nDone, disconnecting DB and exiting!\n\n";
$dbh->disconnect;