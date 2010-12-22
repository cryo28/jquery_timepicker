# JqueryDatepicker
require "app/helpers/timepicker_helper.rb"
require "app/helpers/form_helper.rb"

%w{ helpers }.each do |dir| 
  path = File.join(File.dirname(__FILE__), 'app', dir)  
  $LOAD_PATH << path 
  ActiveSupport::Dependencies.load_paths << path 
  ActiveSupport::Dependencies.load_once_paths.delete(path)
  ActionView::Base.send(:include, TimepickerHelper)
  ActionView::Helpers::FormBuilder.send(:include, FormHelper)
  aux = ActionView::Helpers::AssetTagHelper::JAVASCRIPT_DEFAULT_SOURCES
  aux2 = aux+['jquery','jquery-ui-timepicker-addon']
  ActionView::Helpers::AssetTagHelper::JAVASCRIPT_DEFAULT_SOURCES = aux2	
  ActionView::Helpers::AssetTagHelper::reset_javascript_include_default
end