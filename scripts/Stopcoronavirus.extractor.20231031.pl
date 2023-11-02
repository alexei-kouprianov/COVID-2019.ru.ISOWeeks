#!/usr/bin/env perl
use warnings;
use LWP::Simple;
use utf8;
use strict;
use IO::Compress::Gzip qw(gzip $GzipError) ;

# 20231031 in the filenames = the date when https://стопкоронавирус.рф/ was replaced with
# https://%D0%BE%D0%B1%D1%8A%D1%8F%D1%81%D0%BD%D1%8F%D0%B5%D0%BC.%D1%80%D1%84/stopkoronavirus/
# https://объясняем.рф/stopkoronavirus/ and the reporting format changed;

# <div class="u-table-cv"><div class="u-table-cv__wrapper"><table cellpadding="0" cellspacing="0">

system('rm ../data/post_2023-10-31/post_2023-10-31.date.txt ../data/post_2023-10-31/post_2023-10-31.regions.txt');

my $timestamp = "";

open (SRC00, '<../downloads/post_2023-10-31.txt') or die $!;
open (TGT001, '>>../downloads/post_2023-10-31.single_line.txt') or die $!;
open (TGT002, '>>../data/post_2023-10-31/post_2023-10-31.date.txt') or die $!;
    while(<SRC00>){
        if($_ =~ m/\<h3\>.*?(\d\d).(\d\d).(\d\d\d\d)\)\<\/h3\>/a){
            $timestamp = "$3-$2-$1 12\:34\:56";
            print TGT002 $timestamp, "\n";
            }
        s/\n|\r|[ ]\s+|\t|(?<=\d) (?=\d)|\<b\>|\<\/b\>| style\=\"background-color\: \#ffff00\;\"//g;
        print TGT001 $_;
    }
close(TGT002);
close(TGT001);
close(SRC00);

open (SRC01, '<../downloads/post_2023-10-31.single_line.txt') or die $!;
open (TGT011, '>>../downloads/post_2023-10-31.new_line.txt') or die $!;
open (TGT012, '>>../data/post_2023-10-31/stopkoronavirus.post_2023-10-31.backup.txt') or die $!;
    while(<SRC01>){
        if($_ =~ m/\<div class\=\"u\-table\-cv\"\>\<div class\=\"u\-table\-cv__wrapper\"\>\<table cellpadding\=\"0\" cellspacing\=\"0\"\>(.*?)\<\/table\>/a){
            print TGT011 $1;
            print TGT012 "$timestamp\t$1\n"
        }
    }
close(TGT012);
close(TGT011);
close(SRC01);

open (SRC02, '<../downloads/post_2023-10-31.new_line.txt') or die $!;
open (TGT02, '>>../downloads/post_2023-10-31.raw.txt') or die $!;
    while(<SRC02>){
        s/\<\/td\>\<\/tr\>\<tr\>\<td\> /\n/g;
        s/\<\/td\>\<td\> /\t/g;
        s/\<\/td\>\<\/tr\>\<\/tbody\>| \<colgroup\>.*\n//g;
        print TGT02 $_;
    }
close(TGT02);
close(SRC02);

open (SRC03, '<../downloads/post_2023-10-31.raw.txt') or die $!;
open (TGT031, '>>../data/post_2023-10-31/post_2023-10-31.regions.txt') or die $!;
open (TGT032, '>>../data/post_2023-10-31/post_2023-10-31.federal_disctricts.txt') or die $!;
open (TGT033, '>>../data/post_2023-10-31/post_2023-10-31.Russian_foederation.txt') or die $!;
    while(<SRC03>){
# 'едерац' \xd0\xb5\xd0\xb4\xd0\xb5\xd1\x80\xd0\xb0\xd1\x86
        if($_ =~ m/\xd0\xb5\xd0\xb4\xd0\xb5\xd1\x80\xd0\xb0\xd1\x86/a){
            print TGT033 $timestamp, "\t", $_;
            }
# 'едерал' \xd0\xb5\xd0\xb4\xd0\xb5\xd1\x80\xd0\xb0\xd0\xbb
        elsif($_ =~ m/\xd0\xb5\xd0\xb4\xd0\xb5\xd1\x80\xd0\xb0\xd0\xbb/a){
            print TGT032 $timestamp, "\t", $_;
            }
        else{
            print TGT031 $_;
        }
    }
close(TGT033);
close(TGT032);
close(TGT031);
close(SRC03);

system('rm ../downloads/post_2023-10-31.single_line.txt ../downloads/post_2023-10-31.new_line.txt ../downloads/post_2023-10-31.raw.txt');
