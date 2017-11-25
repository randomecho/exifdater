#!/usr/bin/env ruby
#
# Runs through a folder and prepends all photo filenames with date and time
#
# Author:: Soon Van <cog@randomecho.com>
# Copyright:: Copyright 2013 Soon Van
# License:: BSD 3-Clause License <http://opensource.org/licenses/BSD-3-Clause>
#
# Usage: 
#
#  $ exifdater.rb path/to/photos

require 'exifr'

@found_count = 0
@rename_count = 0
@skip_count = 0
@error_count = 0

def valid_photo(filename)
  if File.extname(filename).downcase.match(/\.jpe?g/)
    return true
  else
    return false
  end
end

def exifdater(photo_dir)
  if File.directory?(photo_dir)
    Dir.foreach(photo_dir) do |photo|
      if valid_photo(photo)
        @found_count += 1
        photo_base = photo_dir + File::SEPARATOR
        photo_file = photo_base + photo
        photo_taken = EXIFR::JPEG.new(photo_file).date_time_original

        unless photo_taken.nil?
          photo_stamp = photo_taken.strftime("%Y%m%d_%H%M%S")

          if File.fnmatch(photo_stamp + '*', photo)
            @skip_count += 1
          else
            begin
              File.rename(photo_file, photo_base + photo_stamp + '-' + photo)
              @rename_count += 1
            rescue
            @error_count += 1
            end
          end
          else
            @error_count += 1
        end
      end
    end
  end
end

if ARGV[0].nil?
  puts "! No folder specified."
  puts "Use the following format: \n\n"
  puts " exifdater.rb path/to/photos"
  exit
else
  exifdater(ARGV[0])
  puts "\nLet's go marking dates in photos..."
  puts @found_count.to_s + " found"
  puts @rename_count.to_s + " renamed"
  
  if @skip_count > 0
    puts @skip_count.to_s + " skipped, date already in filename"
  end

  if @error_count > 0
    puts @error_count.to_s + " photos could not be renamed"
  end
end
