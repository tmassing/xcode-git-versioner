# Xcode auto-versioning script for git
#
# Based on original Perl script by Marcus S. Zarra and Matt Long at
#   (http://www.cimgf.com/2008/04/13/git-and-xcode-a-git-build-number-script/)

# Fail if not run from Xcode
raise "Must be run from Xcode" unless ENV['XCODE_VERSION_ACTUAL']

info_plist = "#{ENV['BUILT_PRODUCTS_DIR']}/#{ENV['INFOPLIST_PATH']}"

# Get the current git revision hash
revision = `/usr/local/bin/git rev-parse --short HEAD`.chomp!

# Open Info.plist and set the CFBundleVersion value to the revision hash
lines = IO.readlines(info_plist).join
lines.gsub! /(<key>CFBundleVersion<\/key>\n\t<string>).*?(<\/string>)/, "\\1#{revision}\\2"

# Overwrite the original Info.plist file with our updated version
File.open(info_plist, 'w') {|f| f.puts lines}

# Report to the user
puts "CFBundleVersion in #{info_plist} set to '#{revision}'"