#!/usr/bin/env perl

# File Name: perl-cgi-images.pl 
# Perl CGI Script to Create Paginated Sheets of Image Galleries
# Made for Photographers
# By Joel Rader  info[at]JoelRader[dot]net
#
# Created: 7/1/2019
# Last Updated: 11/4/2020
# Copyleft 🄯 : 10/17/2019

use strict;
use warnings; 
use diagnostics;


# You may need to install the following 2 perl modules and their dependencies...
use CGI qw(param);
use POSIX qw(ceil);

my $cgi = CGI->new;
my $end = 0;
my $start = 0;
my $element = 0;

# Declare @imagehtml which will later hold array of html for images placed in public folder...
my @imagehtml;

# Place your images (jpgs used here) in a local directory that has public http access
# Next we will "find" all the "jpg", "JPG" or "jpeg" images in your public folder containing your images.  Images to be displayed will be sorted alphanumerically. 
# Arrange photo file names alphanumerically to determine display order when running this script
my @find = `find /var/www/YourSite.net/public_html/YourDirectory . -name "*.jpg" -o -name "*.JPG" -o -name "*.jpeg" | sort --ignore-case`;

print "Content-Type: text/html\n\n";
print "<!DOCTYPE html>\n";
print '<html lang="en">
	<head>
		
		<meta charset="UTF-8">
		<title> Your Heading </title>
		
		<style>

		    img.resize {
			height: auto; 
    			width: auto; 
    			max-width: 300px; 
    			max-height: 300px;
			padding: 6px 6px;
		    }
			
		    img.orientation {
			image-orientation: from-image;	
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
	
	# if @find array contains "jpg", "JPG" or "jpeg"  continue with picture dimensions and URL html
	if (($_ =~ m/\.jpg/i) || ($_ =~ m/\.jpeg/i))  {
		
		chomp($_);
		
		# Change local path to images to a URL
		$_ =~ s/\/var\/www\/YourSite.net\/public_html\//https:\/\/YourSite.net\//;

		# Load array with image html
	 	push @imagehtml, '<a href="'.$_.'"><img class="orientation resize" src="'.$_.'" alt="'.$_.'"></a>'."\n\t";
	}

}

getNumberOfSheets();
print "\t\n<br><br>\n\t";
getImagesPerSheet();
print "\t\n<br><br>\n\t";
getNumberOfSheets();

print "\n    <!-- End Sheet --> \n";

# Change copyright notice to your own site
print '<br><br><a style="font-size: small; color:slategray;" href="https://YourSite.net">Return to the homepage</a>. <br><br><span style="font-size:70%; color:slategray;">Copyleft 🄯 ; 2021 <a href="https://YourSite.net"> Your Name Here </a></span>';
print "</div></body>\n</html>";

sub getNumberOfSheets {

	# get length of image html array 
	my $length = scalar @imagehtml;

	# use POSIX module to get "ceiling" of number of sheets (max 6 images per sheet used here...) 
	my $sheets = ceil($length/6);

	# print sheets menu
	for (my $i=1; $i <= $sheets; $i++){
		print '&nbsp;&nbsp;<a style="color:slategray;" href="./?sheet='.$i.'">Sheet '.$i.'</a> &nbsp;&nbsp;'."\n\t";
	}
}

sub getImagesPerSheet {

		my $param = $cgi->param('sheet');
		
		if ($param){	
		
			my $number = @imagehtml;
				
			$start = ($param * 6 - 6);
			
			$end = $start + 5;
			
			if ($end >= $number){
				$end = $number - 1;
			}			

		} else {
                        
			$end = 5;
                        $start = 0;
		}
		
		my @slice = @imagehtml[ $start .. $end ];
				
		foreach my $element (@slice) {
			print "$element\n";
		}
}

