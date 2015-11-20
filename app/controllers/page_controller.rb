class PageController < ApplicationController

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
		@statistics[:bids_total_cost] = @bids.map(&:total_cost).inject(&:+)
		@statistics[:verbal_closed_bid_follow_ups_count] = @verbal_closed_bid_follow_ups.count
		@statistics[:verbal_closed_bid_follow_ups_cost] = @verbal_closed_bid_follow_ups.map(&:bid).map(&:total_cost).inject(&:+)
		@statistics[:verbal_closed_bid_follow_ups_without_contract] = @uncontracted_bids_count
		@statistics[:signed_contracts] = @signed_contracts.count
		@statistics[:signed_contracts_cost] = @signed_contracts.map(&:bid).map(&:total_cost).inject(&:+)
		@statistics[:outgoing_communications] = @bids_follow_ups.count
		@statistics[:scheduled_appointments] = @inspections.count
		@statistics[:inspection_gross_income] = @inspections.map(&:appointment).map(&:inspFee).inject(&:+)
		@statistics[:total_gross_income] = @statistics[:inspection_gross_income] + @statistics[:signed_contracts_cost]
		@statistics[:contracts] = @contracts.map(&:bid).map(&:total_cost).inject(&:+)
	end

end
