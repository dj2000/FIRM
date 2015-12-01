module ApplicationHelper
	def display_class
		notice['error'] ? "alert-danger" : "alert-success"
	end
end
