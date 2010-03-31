# Install hook code here
require 'ftools'
require 'fileutils'

unless defined? RAILS_ROOT
  RAILS_ROOT = '../../..'
end
puts "Copying files..."
dir = "javascripts"

if !File.exists?("#{RAILS_ROOT}/public/#{dir}/jquery.js")
  dest_file = File.join(RAILS_ROOT, "public", dir, "jquery.js")
  src_file = File.join(File.dirname(__FILE__) , dir, "jquery.js")
  File.copy(src_file, dest_file)

end

if !File.exists?("#{RAILS_ROOT}/public/#{dir}/jquery-ui.js")
  dest_file = File.join(RAILS_ROOT, "public", dir, "jquery-ui-datepicker.js")
  src_file = File.join(File.dirname(__FILE__) , dir, "jquery-ui-datepicker.js")
  File.copy(src_file, dest_file)
end

if !File.exists?("#{RAILS_ROOT}/public/stylesheets/calendar.css")
  dest_file = File.join(RAILS_ROOT, "public", "stylesheets")
  src_file = File.join(File.dirname(__FILE__) , "css","calendar")
  FileUtils.cp(src_file+"/calendar.css", dest_file)
  FileUtils.cp_r(src_file+"/images", dest_file)
end

puts "Files copied - Installation complete!"
