#!/usr/bin/env perl
#
# This file is part of moses.  Its use is licensed under the GNU Lesser General
# Public License version 2.1 or, at your option, any later version.
 
use warnings;                       # import warnings package
use strict;                         # import strict package (type checking?)
use Getopt::Long "GetOptions";      # import a package for command line args
 
my $MORF_DIR;                       # declare local variable MORF_DIR
my $MODEL;                          # declare local variables MODEL
my $TMP_DIR = ".";                  # declare local variable TMP_DIR with initial location "here"
 
# parse command line options
GetOptions("morfessor-dir=s" => \$MORF_DIR, # --morfessor-dirs is a string which goes to MORF_DIR
           "model=s" => \$MODEL,            # --model is a string which goes to MODEL
           "tmpdir=s" => \$TMP_DIR);        # --tmpdir is a string which goes to TMP_DIR
 
die("Must provide --model=s argument") if (!defined($MODEL));   # fail and print an error if they didnt use --model
 
my $cmd = "";                               # declare local variable cmd and initialize to empty string
 
my $ESC_FILE = "$TMP_DIR/morf.esc.$$";      # declare local variable ESC_FILE and initialize to TMP_DIR/morf.esc.$$ (not sure what $$ does, but probably string matching)
 
$cmd = "cat /dev/stdin | sed s/^#/HASH/ > $ESC_FILE";   # put a string in cmd. the command reads from stdin (e.g. the            
                                                        # keyboard or the output of foo in the case of
                                                        # "huda@something $ foo | this_script"), gives what it reads to
                                                        # sed, which finds lines which contain the string "HASH" and
                                                        # outputs those to a file with the name given in $ESC_FILE
print STDERR "Executing: $cmd\n";                       # print to STDERR (so it doesnt go to STDOUT/the file if someone                                   
                                                        # does $ myscript > filename
`$cmd`;                                                 # actually execute the command `cmd` using bash
 
$cmd = "";                                              # reset the cmd variable to empty string
if (defined($MORF_DIR)) {                               # if MORF_DIR was provided
  $cmd .= "PYTHONPATH=$MORF_DIR  $MORF_DIR/scripts/";   # append the string on the RHS to MORF_DIR. it adds MORF_DIR and
                                                        # MORF_DIR/scripts/ to the PYTHONPATH so python can import whatever
                                                        # is in those directories
}
 
my $OUT_FILE = "$TMP_DIR/morf.out.$$";                  # declare local variable OUT_FILE with value
                                                        # $TMP_DIR/morf.out.something
$cmd .= "morfessor-segment "                            # append this long-ass command string to cmd
       ."-L $MODEL "
       ."--output-format \"{analysis} \" "
       ."--output-format-separator \" \" "
       ."--output-newlines "
       ."$ESC_FILE "
       ."| sed 's/ \$//' | sed s/^HASH/#/ > $OUT_FILE"; # this sed finds lines which have both " $" and "HASH" in them
print STDERR "Executing: $cmd\n";                       # print to STDERR again
`$cmd`;                                                 # actually execute cmd using bash
 
 
open(FILE, $OUT_FILE) or die("Can't open file $OUT_FILE");  # open path OUT_FILE into variable file, or fail
while (my $line = <FILE>) {                                 # iterate over all lines in the file
    print "$line";                                          # print every line
}
close(FILE);                                                # close the file
 
unlink($OUT_FILE);                                      # delete variable OUT_FILE for some reason
unlink($ESC_FILE);                                      # delete variable ESC_FILE for some reason
