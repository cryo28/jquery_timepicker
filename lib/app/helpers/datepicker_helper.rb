module DatepickerHelper
  def datepicker_input(model,att)
     ret = text_field(model,att)
     ret += javascript_tag 'jQuery(document).ready(function(){$("#'+model.to_s+'_'+att.to_s+'").datepicker()});'
     return ret
  end
end