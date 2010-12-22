require 'jquery_timepicker.rb'

ActiveScaffold.bridge "Timepicker" do
  install do
    require 'active_scaffold_bridge.rb'
  end
  install? {true}
end if defined?(ActiveScaffold)
