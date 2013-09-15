module ApplicationHelper


  def link_to_with_icon(icon_class, text, url, options = {})
    options[:class] = (options[:class].to_s + ' icon_link').strip
    link_to(font_icon(icon_class) + ' ' + text, url, options)
  end


  def link_to_delete(resource, options={})
    url = options[:url] || object_url(resource)
    confirm = options[:confirm] || "Are you sure?"
    name = options[:name] || font_icon('icon-trash icon-white') + ' ' + "Delete"
    link_to name.html_safe, url,
            :class => options[:class],
            :remote => true,
            :method => :delete,
            :data => {:confirm => confirm}

  end

  def font_icon(icon_class)
    icon_class ? "<i class='#{icon_class}'></i>".html_safe : ""
  end

  def current_user
    @current_user || @current_anonymous_user
  end

  def simple_date(date)
    date.strftime('%b %d, %Y') rescue ""
  end

end
