#!/usr/bin/env perl -w

our $lines=0;
our $words=0;
our $chars=0;
our @fields;

while(<>)
{
	@fields = split ' ';
	$lines += $fields[0];
	$words += $fields[1];
	$chars += $fields[2];
};

print "\t" . $lines . "\t" . $words . "\t" . $chars . "\n";
