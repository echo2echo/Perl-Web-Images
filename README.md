# Perl-Web-Images

This script is for someone (a photographer for example) who would like to display web pages of images paginated into separate sheets/pages.

[Visit this link](https://joelrader.net/cgi-bin/galleries/) to see a demo of the script in action.

This script requires a web server with a cgi-bin that runs perl.  Your server may require installing the Perl modules CGI and POSIX
There are several methods to install these modules.


For example

$ sudo cpan -i CGI 

or 

$ cpanm CGI


Place your images (jpgs used with this script) in a local directory on your server that has public http access such as /var/www/YourSite.net/public_html/YourDirectory

You may have to change permissions on image files with something like..

$ sudo chmod 644 *.JPG

Images to be displayed will be sorted alphanumerically with six images per sheet/page as the current setting. (You can change this if you would like.)
.
Arrange photo file names alphanumerically to determine display order when running this script.

To unzip github zip file use linux "unzip" with the -d flag to upzip into your prefered directory.

Change name of unzipped directory to something like "MyGallery" with the following

$ sudo unzip Perl-Web-Images-main.zip -d /usr/lib/cgi-bin/MyGallery

Next, move unzipped files to your cgi-bin directory.

$ sudo mv /usr/lib/cgi-bin/MyGallery/Perl-Web-Images-main /usr/lib/cgi-bin/MyGallery

Give execute permission to the perl script.

$ chmod 755 perl-cgi-images.pl

Change html to taste and change Copyright to your own site.

Visit your site  http://YourSite.net/cgi-bin/MyGallery/perl-cgi-images.pl to see image gallery.
