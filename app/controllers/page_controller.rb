class PageController < ApplicationController
	before_filter :check_if_active_user ,only: :index
	def index
		today = Date.today
		start_date = today.beginning_of_week
		end_date = today.end_of_week
		@insp_requests = InspRequest.where.not(id: Appointment.all.map(&:inspRequest_id))
		@appointments = Appointment.where.not(id: Inspection.all.map(&:appointment_id))
		@bids = Bid.where(status: ["Pending","Follow-up"]).order(:status).reverse_order
		@unpermitted_permit_informations = PermitInformation.unpermitted_permit_informations
		@permitted_permit_informations = PermitInformation.joins(:permits).where("permits.id IN (?)", Permit.pending_permits.map(&:id))
		@permit_informations = (@unpermitted_permit_informations || [] ) + @permitted_permit_informations
		@comm_histories = CommHistory.where('"callBackDate" <= ? AND bid_id not in (?) AND is_completed = ?', DateTime.now, Bid.accepted_bids.map(&:id), false)
		@projects = Project.where('("scheduleStart" BETWEEN ? AND ?) OR ("scheduleEnd" BETWEEN ? AND ?)', start_date, end_date, start_date, end_date)
		@vc_bids = Bid.accepted_bids.where.not('id in (?)', Contract.where.not({signedBy: nil, dateSigned: nil}).map(&:bid_id))
		@unbided_inspections = Inspection.unbided_inspections
		@unclosed_projects = Project.unclosed_projects
		@contract_pending_projects = Contract.pending_projects
		model_names = [:proj_sched, :proj_insp, :permit, :credit_note, :receipt, :invoice,
			:pay_plan, :inspection, :block_out_period, :agent, :client, :property, :crew, :inspector,
			:svc_area, :commission, :commission_rate, :i_fee_schedule, :svc_criterium, :engineer, :draftsman, :project_payment_schedule]
			model_names.each do |attribute|
				instance_variable_set("@#{attribute.to_s.pluralize}", attribute.to_s.camelize.constantize.all.count)
			end
		end

		def operating_statistics_report
		end

		def statistics
			get_statistics
		end

		def print
			get_statistics
		end

		def get_statistics
			@statistics = {}
			@appointments = Appointment.where('("schedStart" BETWEEN ? AND ?) OR ("schedEnd" BETWEEN ? AND ?)', params[:start_date], params[:end_date], params[:start_date], params[:end_date])
			@bids = Bid.joins(inspection: [:appointment]).where('("schedStart" BETWEEN ? AND ?) OR ("schedEnd" BETWEEN ? AND ?)', params[:start_date], params[:end_date], params[:start_date], params[:end_date])
			@bids_follow_ups = CommHistory.where('("call_time" BETWEEN ? AND ?)', params[:start_date], params[:end_date])
			@verbal_closed_bid_follow_ups = @bids_follow_ups.where(callOutcome: 'Verbal Close')
			@contracts = Contract.all
			@contracts_bid_id = @contracts.map(&:bid_id).uniq
			@uncontracted_bids_count = @verbal_closed_bid_follow_ups.where.not(bid_id: @contracts_bid_id).map(&:bid).count
			@signed_contracts = Contract.signed_contracts(params[:start_date], params[:end_date])
			@inspections = Inspection.where(appointment_id: @appointments.map(&:id))

			## Prepare statistics data
			@statistics[:appointments] = @appointments.count
			@statistics[:insp_requests_count] = InspRequest.where('"callTime" BETWEEN ? AND ?', params[:start_date], params[:end_date]).count
			@statistics[:bids_count] = @bids.count
			@statistics[:bids_total_cost] = @bids.map(&:total_cost).compact.try(:inject, &:+) || 0
			@statistics[:verbal_closed_bid_follow_ups_count] = @verbal_closed_bid_follow_ups.count
			@statistics[:verbal_closed_bid_follow_ups_cost] = @verbal_closed_bid_follow_ups.map(&:bid).map(&:total_cost).compact.try(:inject, &:+) || 0
			@statistics[:verbal_closed_bid_follow_ups_without_contract] = @uncontracted_bids_count
			@statistics[:signed_contracts] = @signed_contracts.count
			@statistics[:signed_contracts_cost] = @signed_contracts.map(&:bid).map(&:total_cost).compact.try(:inject, &:+) || 0
			@statistics[:outgoing_communications] = @bids_follow_ups.count
			@statistics[:scheduled_appointments] = @inspections.count
			@statistics[:inspection_gross_income] = @inspections.map(&:appointment).map(&:inspFee).compact.try(:inject, &:+) || 0
			@statistics[:total_gross_income] = @statistics[:inspection_gross_income] + @statistics[:signed_contracts_cost]
			@statistics[:contracts] = @contracts.map(&:bid).map(&:total_cost).compact.try(:inject, &:+) || 0
	end

	private
	def check_if_active_user
		redirect_to edit_user_registration_url if !current_user.is_active?
	end

end
