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

  def send_call_summary_to_client(client_email, call_summary, file_urls, subject, cc_emails = nil)
    @client_email = client_email
    @call_summary = call_summary
    @file_urls = file_urls
    if @file_urls.present?
      @file_urls.each do |file_url|
        attachments[file_url] = File.read(file_url) if File.exist?(file_url)
      end
    end
    mail(to: @client_email, cc: cc_emails, subject: subject)
  end

  def send_email_to_crew(project, file_urls=nil)
    @project = project
    @crew = @project.try(:primary_crew)
    @file_urls = file_urls
    if @file_urls.present?
      @file_urls.each do |file_url|
        attachments[file_url] = File.read(file_url) if File.exist?(file_url)
      end
    end
    mail(to: @crew.try(:email), subject: "Crew Data Sheet")
  end

  def send_email_for_permit(draftsman, permit_information, ccs, notes, contents, file_urls=nil)
    @draftsman = draftsman
    @permit_information = permit_information
    @project = @permit_information.project
    @notes = notes
    @file_urls = file_urls
    @contents = contents
    if @file_urls.present?
      @file_urls.each do |file_url|
        attachments[file_url] = File.read(file_url) if File.exist?(file_url)
      end
    end
    mail(to: @draftsman.try(:email), cc: ccs, subject: "Permit Information Sheet")
  end
end