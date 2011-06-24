#!/usr/bin/ruby -w
#
# Copyright:: Copyright 2007 Google Inc.
# License:: All Rights Reserved.
# Original Author:: Scott Shattuck (mailto:idearat@google.com)
#
# Simple tagfile generator for JavaScript supporting a variety of common
# syntax idioms for finding/tagging function and type declarations in JS.


# Iterate over a list of directory names, building up a list of files which is
# filtered to include/exclude paths based on the command line -i and-e flags. 
#
# Default file exclusions include *-bundle.js files which are produced by the
# jsCompiler. Default directory exclusions include any CVS, .svn, .snapshot,
# and .mozilla directory trees. You can use the -i and -e flags to manipulate
# the include and exclude lists from the command line. Include list entries
# take precedence over exclusions, allowing you to exclude less specific 
# patterns. The return value from this function (an array of file names) can
# be used as input to the processTags call.
#
#
# Args:
# - dirs: [String, String, ...] -- Each string should be a directory name.
#
# Returns:
# - list: [String, String, ...] -- Each string is a file name to process.
#
def getFiles(dirs)
  files = []
  for dir in dirs
    Find.find(dir) do |path|
        files << path if goodPath(path)
    end
  end
  return files
end



# Tests a path against the exclude/include lists and returns true if the path
# matches current requirements for inclusion.
#
#
# Args:
# - path: String -- A valid pathname to test.
#
def goodPath(path)

  # all non-js files are automatically excluded since we're tagging JS
  return false unless path =~ /\.js$/
  
  # exclude anything matching an exclude entry, unless overridden by a
  # matching include pattern
  $excludes.each do |exre|
    unless (path =~ exre).nil?
      return false unless $includes.size > 0
      $includes.each do |inre|
        return !(path =~ inre).nil?
      end
    end 
  end
  return true

end

# Performs overall processing for the script, managing command line flags and
# invoking the proper subcomponent calls to build the requested output file.
#
#
# Returns:
# - null
#
def main
  arg_parser=GetoptLong.new
  arg_parser.set_options(
    ["-e", "--exclude", GetoptLong::REQUIRED_ARGUMENT],
    ["-i", "--include", GetoptLong::REQUIRED_ARGUMENT],
    ["-h", "--headers", GetoptLong::NO_ARGUMENT],
    ["-u", "--usage", GetoptLong::NO_ARGUMENT])

  arg_parser.each do |opt, arg|
    begin
        case opt
          when "-u"
            usage()
            exit(0);
          when "-h"
            printHeader
          when "-i"
            $includes.push(arg)
          when "-e"
            $excludes.push(arg)
        end
    rescue => err; puts err; break;
    end
  end

  # after all args if we still don't have a directory then show usage
  if (ARGV.length != 1)
    usage();
  end

  # convert strings to regexs once, rather than during filtering loop
  $excludes.collect! {|str| Regexp.new(str)}
  $includes.collect! {|str| Regexp.new(str)}

  processTags(getFiles(ARGV.shift))
  return
end


# Print a ctags-compliant set of metadata lines describing the tag file. This
# method is invoked if the -h/--header flag is present, otherwise the output
# does not include header information so it can be concatenated with other tag
# file data.
#
#
# Returns:
# - null
#
def printHeader
  puts "!_TAG_FILE_FORMAT\t2\t/extended format/\n" 
  puts "!_TAG_FILE_SORTED\t0\t/0=unsorted, 1=sorted, 2=foldcase/\n"
  puts "!_TAG_PROGRAM_AUTHOR\tScott Shattuck\t/idearat@google.com/\n"
  puts "!_TAG_PROGRAM_URL\t//\n"
  puts "!_TAG_PROGRAM_NAME\tjstags.rb\t//\n"
  puts "!_TAG_PROGRAM_VERSION\t1.0\t//\n"
  return
end


# Iterate over a list of filenames, generating appropriate ctags file entries
# for each file. The file list is presumed to have been filtered for any
# exclusions prior to passage to this routine. See getFiles for more info.
#
# Common source patterns searched include: type.prototype.sym=*, sym=function, 
# sym=new Function, sym:function, and function sym() which are common ways of
# declaring instance properties/methods, types, or global functions.
#
# Output is written to stdout so it can be redirected or filtered easily.
#
# Args:
# - list: [String, String, ...] -- Each string is a filename to process.
#
# Returns:
# - null
#
def processTags(files)
  files.each do |file|
    count = 0
    File::readlines(file).each do |line|
      count+=1

      # function sym (
      line.gsub(/function ([\w_$]+)([\s]*)\(/) {|match|
        puts $1 << "\t" << file << "\t" << '/' << match << '/' << ';"'
        match
      }

      # obj.prototype.sym =
      line.gsub(/([\w_$]+)\.prototype\.([\w_$]+)([\s]*)=/) {|match|
        puts $2 << "\t" << file << "\t" << '/' << match << '/' << ';"'
        match
      }

      # this.sym = [new] [Ff]unction
      line.gsub(/this\.([\w_$]+)([\s]*)=([\s]*)(new[\s])*[Ff]unction/) {|match|
        puts $1 << "\t" << file << "\t" << '/' << match << '/' << ';"'
        match
      }

      # goog.namespace.sym =
      line.gsub(/goog\.([\w_$]+)\.([\w_$]+)([\s]*)=/) {|match|
        puts $2 << "\t" << file << "\t" << '/' << match << '/' << ';"'
        match
      }

      # sym : [new] [Ff]unction
      line.gsub(/([\w_$]+)([\s]*):([\s]*)(new[\s])*[Ff]unction[\W]/) {|match|
        puts $1 << "\t" << file << "\t" << '/' << match << '/' << ';"'
        match
      }
    end
  end
  return
end


# Outputs instructions on how to use this script. Invoked when no arguments
# are provided, required args are missing, or when the -u[sage] flag is used.
#
#
# Returns:
# - null
#
def usage
  puts "usage: jstags.rb [-e] [-i] [-h] [-u] directory_name"

  puts "args :\n"
  puts "  -e  exclude path(s) matching regex argument\n"
  puts "  -i  include path(s) matching regex argument\n"
  puts "  -h  output a standard set of ctags headers\n"
  puts "  -u  produce this output; override other flags\n"
  puts "  directory_name - name of directory to scan\n"

  puts "\nOutput is written to stdout so you can redirect/filter as needed.\n"
  puts "\nSupported source code patterns for locating tag symbols include:\n"
  puts "  sym=function, sym=new Function, sym:function, and function sym().\n\n"

  exit(0)
end


# Handles script operation when run from the command line, loading necessary
# prerequisite modules, determining minimum argument list is provided, and
# configuring default values. Final task is invocation of the main() function.
#
#
if __FILE__ == $0
  require 'getoptlong'
  require 'find'

  if ARGV.length == 0
    usage()
  end

  # default inclusion/exclusion lists for build/version control artifacts
  $excludes = ['CVS', '.svn', '.snapshot', '.mozilla', '-bundle.js']
  $includes = []

  main()
  exit(0)
end

