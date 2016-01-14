module ApplicationHelper
	# Generate error messages content
  def error_messages_for object
    error_content = ''
    if object
	    if object.errors.any?
	      error_content += content_tag(:div, :class => 'alert alert-danger text-center') do
	        content_tag(:ul, class: 'list-unstyled') do
	          object.errors.full_messages.each do |message|
	            concat content_tag(:li, "#{message}") if message.present?
	          end
	        end
	      end
	    end
	  end
    error_content.html_safe
  end
end
