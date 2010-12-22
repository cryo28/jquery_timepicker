require 'fileutils'

timepicker_file   = 'jquery-ui-timepicker-addon.js'
dst_in_rails_root = File.join('public/javascripts', timepicker_file)
dst_path          = File.join(RAILS_ROOT, dst_in_rails_root)

puts 'Installing jquery-timepicker'
unless File.symlink?(dst_path) || File.exists?(dst_path)
  begin
    File.symlink(
        '../../vendor/plugins/jquery_timepicker/jquery_timepicker_addon/' + timepicker_file,
        dst_path
    )
    puts "Symlink created"
  rescue NotImplementedError => e
    File.copy(File.join(File.dirname(__FILE__), 'jquery_timepicker_addon/' + timepicker_file), dst_path)
    puts "File copied"
  end
end
puts 'Installation complete. Please make sure you use jQuery and jQuery UI (calendar and slider) i.e. from Google CDN'

