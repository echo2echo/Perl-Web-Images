#!/usr/bin/env perl

# File name: resize_image.pl
# Perl script to resize jpg and png images
# By Joel Rader  info[at]joelrader[dot]net
# Create resized images of files (jpg jpeg) with size of your choice
# The script works as a thumbnail generator

use strict;
use warnings;
use diagnostics;

#The next commented line is for testing ( working on png support... See "Issues" )
#my @find = `find . -name "*.jpg" -o -name "*.JPG" -o -name "*.jpeg" -o -name "*.JPEG" -o -name "*.png" -o -name "*.PNG" |  sort --ignore-case`;
my @find = `find . -name "*.jpg" -o -name "*.JPG" -o -name "*.jpeg" -o -name "*.JPEG" |  sort --ignore-case`;



my $thumb;
my $fileSize;
my $fileName;

foreach (@find) {

        $fileName = $_;

        chomp $fileName;

        $fileSize = -s $fileName;

        # if the "thumb_" file is already there go to next in array     
        if ( $fileName =~ m/thumb_/g ) { print "Skip thumb $fileName\n"; next; }

        # if the file size is greater than 1 MB continue on and resize image

        # Change the following value of $bigfile to the smallest size of the image files you would like to replace
        # All images larger than assigned below will have a resized image created
        # 1 MB is used here...
        my $bigfile = 1000000;

        if ( $fileSize > $bigfile ) {

                # If you do not want to include resizing images from a subdirectory modify the following
                # change foldernametoskip on the next line 
                if ( $fileName =~ m/foldernametoskip/ ) { print "Skip folder $fileName\n"; next; }

                resize();

                print "Made thumb from $fileName\n";
        }
}


sub resize {

        $fileName =~ s/\.\///;

        # You may need to install imagemagick. 
        # On Ubuntu linux try the following...
        # $ sudo apt install imagemagick 
        # or build from source... see  https://imagemagick.org for instructions
        # This command will overwrite the existing images named "thumb_*"
        # -resize x400 sets all generated files to a height of 400... change as needed
        $thumb = `convert $fileName -resize x400 thumb_$fileName 2>/dev/null`;

}
