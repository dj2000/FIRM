class PermitInformationsController < ApplicationController
	def send_email
		@draftsman = Draftsman.find(params[:draftsman_id])
		file_urls = params[:file_urls].split(",") if params[:file_urls].present?
		@permit_information = PermitInformation.find(params[:permit_information_id])
		UserMailer.send_email_for_permit(@draftsman, @permit_information, params[:cc_emails], params[:notes], file_urls).deliver
    respond_to do |format|
      format.html{ redirect_to root_path, notice: 'Email is sent successfully.' }
    end
	end
end
