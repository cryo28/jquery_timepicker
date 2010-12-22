module TimepickerHelper
  def timepicker_input(model,att)
     ret = text_field(model,att)
     ret += javascript_tag 'jQuery(document).ready(function(){$("#'+model.to_s+'_'+att.to_s+'").datetimepicker()});'
     return ret
  end
end
