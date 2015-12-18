class UserMailer < ActionMailer::Base
  default from: "support@support.com"
  def send_appointment(appointment, client_property, agent_client)
  	@appointment = appointment
  	@client_property = client_property
  	@agent_client = agent_client
    mail(to: @appointment.inspector.try(:email), subject: 'Appointment Sheet') do |format|
			format.html
      attachments["appointment_sheet.pdf"] = WickedPdf.new.pdf_from_string(
        render_to_string(pdf: 'appointment_sheet', template: 'appointments/_appointment.html.erb')
      )
	  end
  end

  def send_call_summary_to_client(client, call_summary, file_urls)
    @client = client
    @call_summary = call_summary
    @file_urls = file_urls
    file_urls.each do |file_url|
      attachments[file_url] = File.read(file_url)
    end
    mail(to: @client.email, subject: 'Call Summary')
  end
end