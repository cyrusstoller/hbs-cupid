module ApplicationHelper
  def title
    base_title = "Cupid"
    if @title.blank?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def alert_type(type)
    case type
    when :error, "error"
      "alert"
    when :notice, "notice"
      "warning"
    when :success, "success"
      "success"
    else
      type.to_s
    end
  end
  
  # For nested forms based on
  # http://railscasts.com/episodes/197-nested-model-form-part-2
  
  def link_to_remove_fields(name, f, options = {})
    opts = options.merge({:onclick => "remove_fields(this); return false;"})
    f.hidden_field(:_destroy) + link_to(name, "#", opts)
  end
  
  def link_to_add_fields(name, f, association, options = {})
    options[:object] ||= f.object.class.reflect_on_association(association).klass.new
    options[:partial] ||= association.to_s.singularize + "_fields"
    options[:form_builder_local] ||= :f
    options[:text_input_class] ||= nil
    fields = f.fields_for(association, options[:object], :child_index => "new_#{association}") do |builder|
      render(:partial => options[:partial], 
             :locals => { options[:form_builder_local] => builder, :text_input_class => options[:text_input_class],
                          :label_column_class => options[:label_column_class] })
    end
    link_to(name, "#", :onclick => %(add_fields(this, "#{association}", "#{escape_javascript(fields)}"); return false;), :class => options[:class])
  end
end
