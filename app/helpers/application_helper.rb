module ApplicationHelper

	def phone
	  number_to_phone(18667504773, delimiter: ' ', area_code: true,  class: "phone-link")
	  # number_to_phone(8667504773, delimiter: ' ', country_code: 1, area_code: true, pattern: /(\d{1})(\d{3})(\d{4})$/,  class: "phone-link")
	end

	def conversations_windows
    params[:controller] != 'messengers' ? @conversations_windows : []
  end
end
