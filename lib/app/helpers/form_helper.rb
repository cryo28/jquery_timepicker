module FormHelper
  def timepicker(method, options)
    timepicker_input(self.object_name, method, options)
  end
end
