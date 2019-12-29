#!/usr/bin/env perl
use strict;
use warnings;
use version; our $VERSION = qv('1.0.0');

# alias autoprove="nodemon --watch t --watch sql -e pl,t,pm,sql -x 'clear && timeout 2s prove -Q t/**'"


use Test::More::Behaviour;
use Data::Dumper::Simple;
use DBI;
use File::Slurp;

my $database = 'sakila';
my $hostname = 'localhost';
my $user     = 'test';
my $password = 'test';
my $dsn      = "dbi:mysqlPP:database=$database;host=$hostname";
my $dbh      = DBI->connect( $dsn, $user, $password );

describe 'Query' => sub {
    it 'Returns same data' => sub {
        my $result1 = query_1();
        my $result2 = query_2();
        is_deeply( $result1, $result2 );

    };
};

sub query_1 {
    my $sth = $dbh->prepare( scalar read_file('sql/query1.sql') );
    $sth->execute;
    return $sth->fetchall_arrayref;
}

sub query_2 {
    my $sth = $dbh->prepare( scalar read_file('sql/query2.sql') );
    $sth->execute;
    return $sth->fetchall_arrayref;
}
done_testing;

1;
