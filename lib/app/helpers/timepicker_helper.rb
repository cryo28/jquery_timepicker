module TimepickerHelper
  def timepicker_input(object_name, method, options)
    id  = options[:id] || "#{object_name}_#{method}"
    res = text_field(object_name, method, options)

    res += javascript_tag(%Q|
      jQuery(function() {
        jQuery('##{id}').datetimepicker(jQuery.extend({showButtonPanel: true}, jQuery.datepicker.regional['ru']));
      });
    |)
    res
  end
end
