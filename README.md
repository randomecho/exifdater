# Exifdater

Runs through a folder and prepends all photo filenames with its taken date and 
time according to the Exif data. The heavy lifting is done by the exifr gem. 
This is just a hitch for it.

## Usage

    $ exifdater.rb path/to/photos

### Requirements

EXIF Reader. If you don't have the gem, install it.

    gem install exifr

## License

[BSD 3-Clause License](http://opensource.org/licenses/BSD-3-Clause).

