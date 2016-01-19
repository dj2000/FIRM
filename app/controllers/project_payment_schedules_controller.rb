class ProjectPaymentSchedulesController < ApplicationController
	before_action :projects

	def index
	end

	def load_project_payment_schedules
		@project = Project.find(params[:project_id])
		@bid = @project.try(:contract).try(:bid)
		@pay_plan = @bid.try(:payPlan)
		if @project.project_payment_schedules.present?
			@project_payment_schedules = @project.project_payment_schedules
		else
			@payments = Array.new
			@payments << Payment.create(title: @pay_plan.try(:deposit_label) || "Deposit" , pay_plan_id: @pay_plan.id, value: @pay_plan.try(:deposit), payment_type: "Deposit")
			@payments = @payments + @pay_plan.try(:payments)
			@project_payment_schedules = @project.project_payment_schedules.build
		end
		respond_to do |format|
			format.js
		end
	end

	private

	def projects
		@projects = Project.all.map{|p| [p.title, p.id]}
	end
end
