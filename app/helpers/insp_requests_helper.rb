module InspRequestsHelper

	def get_client_select_values(clients)
		option_value = ''
		if clients.present?
			clients.each do |client|
				option_value += content_tag(:div, data: {value: "#{client.id}", selectable: ""	}, class: 'option') do

					client.firstName
				end
			end
		end
		option_value.html_safe
	end
end
