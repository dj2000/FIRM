class PermitInformationsController < ApplicationController
	def send_email
		@draftsman = Draftsman.find(params[:draftsman_id])
		file_urls = params[:file_urls].split(",") if params[:file_urls].present?
		@permit_information = PermitInformation.find(params[:permit_information_id])
		UserMailer.send_email_for_permit(@draftsman, @permit_information, params[:cc_emails], params[:notes], params[:contents], file_urls).deliver
    respond_to do |format|
      format.html{ redirect_to root_path, notice: 'Email is sent successfully.' }
    end
	end

	def load_email_template
		@permit_information = PermitInformation.find(params[:id])
		@project = @permit_information.try(:project)
		@inspection = @project.try(:contract).try(:bid).try(:inspection)
		respond_to do |format|
			format.js
		end
	end
end
