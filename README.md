# Perl-Web-Images

#
# Instructions for resize_images.pl
#

This script was made on Ubuntu Linux

Are your camera's image file sizes getting larger and larger and make page loading a little too slow?

Try this script ( resize_images.pl ) to resize your jpg and png images and bring back that quick page load to your web page.

Run this script before the perl-cgi-images.pl cgi script whose instructions are listed below... 

Place the images ( jpg png ) you would like to display in a public folder such as the following...

    /var/www/MySite.net/public_html/MyDirectory

Then place the resize_images.pl script in the same directory as your images

You will need to install imagemagick for this script to run

To install imagemagick on Ubuntu Linux try the following...

      $ sudo apt install imagemagick 

You can also build from source... see  https://imagemagick.org for instructions

[A helpful page to install imagemagick with instructions to add png support found here](https://linuxconfig.org/how-to-install-imagemagick-7-on-ubuntu-18-04-linux)  

Try the following after installing imagemagick to see if your image type is supported.

        $ identify -version

When run, this script (resize_images.pl) will create or overwrite thumb images named "thumb_*"

Run the chmod (permissions) command as follows to give permission to run the script
 
     $ sudo chmod 755 resize_images.pl

Run the following command to create thumbnails (May require sudo)
 
    $ sudo ./resize_images.pl 

If it works you will see a generated list of image files converted to thumbnails

It can take a few seconds per photo to process the image to a thumbnail.

#
# Instructions for perl-cgi-images.pl
#

This script (perl-cgi-images.pl) is for someone (a photographer for example) who would like to display web pages of resized images paginated into separate sheets/pages.

Very good for sharing photos with family and friends.

[Try here for a demo gallery](https://joelrader.net/cgi-bin/backgrounds/)

This script requires a web server with a cgi-bin that runs Perl.  

Place your images ( jpg png ) in a public directory (as mentioned earlier) on your server that has public http access such as /var/www/YourSite.net/public_html/YourDirectory and run the resize_images.pl script.

You may have to change permissions on image files with something like..

    $ sudo chmod 744 *.JPG

Images to be displayed will be sorted alphanumerically with six images per sheet/page as the current setting. (You can change this number if you would like.)
.
Arrange photo file names alphanumerically to determine display order when running this script.
-
Give execute permission to the perl script.

     $ chmod 755 perl-cgi-images.pl 

Change name of perl file perl-cgi-images.pl to index.pl

    $ sudo mv perl-cgi-images.pl index.pl

See notes and other instructions in the Perl script

Change html to taste and change Copyright to your own site.

This script will display thumbnail images having the text "thumb_" in the filename.

Use the resize_images.pl script with the instructions above to generate resized images and change image file size and rename img file with "thumb_" filename.

When viewing the page the thumbnails are displayed. if you would like to see the full sized original file, click on a thumbnail

Visit your site at something like http://YourSite.net/cgi-bin/MyGallery/ to see your image gallery.
