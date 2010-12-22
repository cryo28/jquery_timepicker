# JqueryDatepicker
require "app/helpers/timepicker_helper.rb"
require "app/helpers/form_helper.rb"

%w{ helpers }.each do |dir| 
  path = File.join(File.dirname(__FILE__), 'app', dir)  
  $LOAD_PATH << path
  (ActiveSupport::Dependencies.respond_to?(:autoload_paths)      ? ActiveSupport::Dependencies.autoload_paths : ActiveSupport::Dependencies.load_paths) << path
  (ActiveSupport::Dependencies.respond_to?(:autoload_once_paths) ? ActiveSupport::Dependencies.autoload_once_paths : ActiveSupport::Dependencies.load_once_paths).delete(path)
  ActionView::Base.send(:include, TimepickerHelper)

  ActionView::Helpers::FormBuilder.send(:include, FormHelper)

  ActionView::Helpers::AssetTagHelper.register_javascript_expansion :jquery_timepicker => 'jquery-ui-timepicker-addon'
  ActionView::Helpers::AssetTagHelper.register_stylesheet_expansion :jquery_timepicker => 'http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.6/themes/south-street/jquery-ui.css'


  ActionView::Helpers::AssetTagHelper.register_javascript_expansion(:jquery_cdn        => %w|
        http://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.js
        http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.4/jquery-ui.js
        http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.4/i18n/jquery-ui-i18n.js
  |)

#  aux = ActionView::Helpers::AssetTagHelper::JAVASCRIPT_DEFAULT_SOURCES
#  aux2 = aux+['jquery-ui-timepicker-addon']
#  ActionView::Helpers::AssetTagHelper::JAVASCRIPT_DEFAULT_SOURCES = aux2
  ActionView::Helpers::AssetTagHelper::reset_javascript_include_default
end
