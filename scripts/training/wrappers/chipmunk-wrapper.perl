#!/usr/bin/env perl
#
# This file is part of moses.  Its use is licensed under the GNU Lesser General
# Public License version 2.1 or, at your option, any later version.


#this is the wrapper for the chipmunk stemmer (to be used as a factor)
use warnings;
use strict;

my ($lang,$libs,$in,$out) = @ARGV;

open(IN,$in);
open(OUT,">$out");
open(TEMP,">$out"."_CHIP_temp");
binmode(IN, ":utf8");
binmode(OUT, ":utf8");
binmode(TEMP, ":utf8");


while(<IN>) {
    my $first = 1;
    chomp; s/\s+/ /g; s/^ //; s/ $//;

    foreach my $word (split) {
    	print TEMP $word;
	print TEMP "\n";
    }
    print TEMP "*END*\n"; 
}
my $cmd = "";
$cmd .= "java -cp " . $libs . " chipmunk.segmenter.cmd.Stem";
$cmd .= " --model-file /home/huda/chipmunk/models/" . $lang . ".chipmunk.srl";
$cmd .= " --input-file " . $out."_CHIP_temp";
$cmd .= " --output-file " . $out;
$cmd .= " --mode root-detection";
$cmd .= " --format sentence";

`$cmd`; 

close(OUT);
close(TEMP);
close(IN);
