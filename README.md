# Perl-Web-Images

This script is for someone who would like to display images on paginated sheets

This script requires a web server with a cgi-bin that runs perl.  Your server may require installing the Perl modules CGI and POSIX
There are several methods to install these modules.

For example
$ sudo cpan -i CGI 
or 
$ cpanm CGI

Place your images (jpgs used with this script) in a local directory on your server that has public http access such as /var/www/YourSite.net/public_html/YourDirectory

The "find" command will retrieve all the "jpg", "JPG" or "jpeg" images in your public folder containing your images.

Images to be displayed will be sorted alphanumerically with six images per page (You can change this if you would like 

Arrange photo file names alphanumerically to determine display order when running this script

Place the perl script in a folder in your cgi-bin.  Something like /usr/lib/cgi-bin/MyGallery

Give execute permission to the perl script.
$ chmod 755 perl-cgi-images.pl

Change html to taste and change Copyright to your site
