class ProjectPaymentSchedulesController < ApplicationController
	before_action :projects

	def index
		create_payment_schedules if params[:project_id].present?
	end

	def load_project_payment_schedules
		create_payment_schedules
		respond_to do |format|
			format.js
		end
	end

	def create_payment_schedules
		@bid = @project.try(:contract).try(:bid)
		@pay_plan = @bid.try(:payPlan)
		@insp_request = @bid.try(:inspection).try(:appointment).try(:insp_request)
		@appointment = @insp_request.try(:appointment)
		if @project.project_payment_schedules.present?
			@project_payment_schedules = @project.project_payment_schedules
		else
			@payments = Array.new
			@payments << Payment.find_or_create_by(title: @pay_plan.try(:deposit_label) || "Deposit" , pay_plan_id: @pay_plan.id, value: @pay_plan.try(:deposit), payment_type: "Deposit")
			@payments = @payments + @pay_plan.try(:payments)
			@project_payment_schedules = @project.project_payment_schedules.build
		end
	end

	private

	def projects
		@project = Project.find(params[:project_id]) if params[:project_id].present?
		@projects = Project.all.map{|p| [p.title, p.id]}
	end
end
