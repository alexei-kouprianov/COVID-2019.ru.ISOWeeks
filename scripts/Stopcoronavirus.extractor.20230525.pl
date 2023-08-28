#!/usr/bin/env perl
use warnings;
use LWP::Simple;
use utf8;
use strict;
use IO::Compress::Gzip qw(gzip $GzipError) ;

# 20230525 in the filenames = the date when https://стопкоронавирус.рф/ changed their reporting format;

# Fetcher block;

system("wget 'https://стопкоронавирус.рф/information/' -o stpk.log -O stopcoronavirus.rf.20230525.txt");

# Parser block #1;

my $string = "";
my $timestamp = "";
my $JSON = "";
my $inputfile = '../downloads/stopcoronavirus.storage.cumulative.20230525.txt';
my $outputfile = '../downloads/stopcoronavirus.storage.cumulative.20230525.txt.gz';

open (SRC01, '<stopcoronavirus.rf.20230525.txt') or die $!;
open (TGT011, '>>../downloads/stopcoronavirus.storage.cumulative.20230525.txt') or die $!;
open (TGT012, '>../downloads/stopcoronavirus.storage.moment.20230525.json') or die $!;
open (TGT013, '>../downloads/stopcoronavirus.timestamp.moment.20230525.txt') or die $!;
while (<SRC01>) {
	if($_ =~ m/.*\<period\-date\-formatter date\=\"(.*?)\"\>/a){
		$timestamp = $1;
	}
	elsif($_ =~ m/^.*?(\[\{\"title\"\:.*\}\])/a){
		$JSON = $1;
	}
}
	print TGT011 $timestamp, "\t", $JSON, "\n";
	my $JSONm = $JSON =~ s/' .*//g;
	print TGT012 $JSONm, "\n";
	print TGT013 '"', $timestamp,'"', "\n";
close TGT013;
close TGT012;
close TGT011;
close SRC01;

my $status = gzip $inputfile => $outputfile
        or die "gzip failed: $GzipError\n";
