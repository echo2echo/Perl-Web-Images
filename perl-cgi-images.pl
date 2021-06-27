#!/usr/bin/env perl

# File Name: perl-cgi-images.pl 
# Perl CGI Script to Create Paginated Sheets of Image Galleries
# Made for Photographers
# By Joel Rader  info[at]JoelRader[dot]net

use strict;
use warnings; 
use diagnostics;

use POSIX qw(ceil);

# Declare variables
my $end = 0;
my $start = 0;
my $element = 0;
my $originalPath;

# Declare @imagehtml which will later hold array of html for images placed in public folder...    
my @imagehtml;

# Place your images ( jpg jpeg and png ) in a local directory that has public http access
# Next we will "find" all the "jpg", "jpeg" or "png" images in your public folder containing your images.  Images to be displayed will be sorted alphanumerically. 
# Arrange photo file names alphanumerically to determine display order when running this script
my @find = `find /var/www/YourSite.net/public_html/YourDirectory . -name "*.jpg" -o -name "*.JPG" -o -name "*.jpeg" -o -name "*.JPEG" -o -name "*.png" -o -name "*.PNG" |  sort --ignore-case`;

print "Content-Type: text/html\n\n";
print "<!DOCTYPE html>\n";
print '<html lang="en">
	<head>
		
		<meta charset="UTF-8">
		<title> Your Title Here </title>
		
		<style>

		img.resize {

                        height: 475px;
                        width: auto;
                        padding: 6px 6px;

                }

		
		</style>	

	</head> 
	<body>
		<div style="text-align:center;">
		<h2 style="color:slategray;">Your Heading </h2>
		<h3 style="color:slategray;">Your Subheading</h3>
		
	<!--  Begin Sheet -->
';

foreach(@find){

        $originalPath = $_;

        if ($_ =~ m/thumb_/) {

                        chomp($_);

			# Changes local path to images to a URL
			# Change YourSite.net to your own site info                 
			$_ =~ s/\/var\/www\/YourSite.net\/public_html\//https:\/\/YourSite.net\//;
                        $originalPath =~ s/\/var\/www\/YourSite.net\/public_html\//https:\/\/YourSite.net\//;
                        $originalPath =~ s/thumb_//;
                        # Load array with image html
                        push @imagehtml, '<a href="'.$originalPath.'"><img class="resize" src="'.$_.'" alt="'.$_.'"></a>'."\n\t";
        }
}

getNumberOfSheets();
print "\t\n<br><br>\n\t";
getImagesPerSheet();
print "\t\n<br><br>\n\t";
getNumberOfSheets();

print "\n    <!-- End Sheet --> \n";

# Change copyright notice to your own site
print '<br><br><a style="font-size: small; color:slategray;" href="http://YourSite.net">Return to the homepage</a>. <br><br><span style="font-size:70%; color:slategray;">Copyleft 🄯 ; 2021 <a href="http://YourSite.net"> Your Name Here </a></span>';
print "</div></body>\n</html>";

sub getNumberOfSheets {

	# get length of image html array 
	my $length = scalar @imagehtml;

	# use POSIX module to get "ceiling" of number of sheets (max 6 images per sheet used here...) 
	my $sheets = ceil($length/6);

	# print sheets menu
	for (my $i=1; $i <= $sheets; $i++){
		print '&nbsp;<a style="color:slategray;" href="./?sheet='.$i.'">Sheet '.$i.'</a> &nbsp;'."\n\t";
	}
}

sub getImagesPerSheet {
		# Get sheet number from url
		my $param = $ENV{'QUERY_STRING'};
                
		if ($param =~ m/sheet=(\d+)/) {

                        $param = $1;
			
			# Get number of images found in @imagehtml array
			my $number = @imagehtml;
				
			$start = ($param * 6 - 6);
			
			$end = $start + 5;
			
			if ($end >= $number){
				$end = $number - 1;
			}			

		} else {
                        # If sheet param not in, url start counting at 0 and end wirh sheet number minus 1 ( 5 here )
 			$end = 5;
                        $start = 0;
		}
		
		my @slice = @imagehtml[ $start .. $end ];
				
		foreach $element (@slice) {
			print "$element\n";
		}
}

