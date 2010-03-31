module FormHelper
  def datepicker(att)
     model = self.object_name
     ret = self.text_field att
     ret += '<script type="text/javascript">jQuery(document).ready(function(){$("#'+model+'_'+att.to_s+'").datepicker()});</script>'
     return ret
 end
 
end
