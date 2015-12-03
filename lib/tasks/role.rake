namespace :role do
  desc "TODO"
  task user_role: :environment do
   create_role
  end

  def create_role
    roles = {
      "Inspection coordinator" => "Access to insp cordinator menu and svcarea and inspectors under general menu.",
      "Exec director" => "Access to office processing and general menu." ,
      "Project Coordinator" => "Access to project coordinator and office processing menu and manage crew",
      "Inspector" =>"access to inspection entry, inspection schedule and bids",
      "Crew" => "access to project/crew schedule",
      "Executive Staff" =>"same as admin but read-only" }
    roles.each do |role, desc|
      Role.find_or_create_by(title: role) do |new_role|
        new_role.name = role
        new_role.title = role
        new_role.description = desc
        new_role.the_role = get_permission(role)
        new_role.save
      end
    end
    puts "------ Role Created Successfully ---------"
  end

  def get_permission(role)
    denied_permission = {}
    roles = get_role(role)
    roles.each do |role|
      hash,temp = {}, {}
      controller_action = eval(role.camelize + "Controller").action_methods
      actions = (controller_action - ApplicationController.action_methods).to_a
      actions.map {|action| temp[action] = false }
      denied_permission[role] = temp
    end
    denied_permission
  end

  def get_role(role)
    general = ["svc_criteria", "i_fee_schedules", "commission_rates", "commissions", "svc_areas", "inspectors", "crews"]
    insp_coordinator = ["insp_requests", "properties", "clients", "agents", "appointments", "block_out_periods"]
    office_processing = ["inspections","pay_plans", "invoices","receipts","credit_notes","permits","bids","permits", "proj_insps"]
    proj_coordinator = ["comm_histories","contracts","projects","proj_scheds"]
    the_role = []
    case role
      when "Inspection coordinator"
        the_role = (general + office_processing + proj_coordinator) - ["svc_areas", "inspectors"]
      when "Exec director"
        the_role = insp_coordinator + proj_coordinator
      when "Project Coordinator"
        the_role = insp_coordinator
      when "Inspector"
        the_role = (general + office_processing + proj_coordinator + proj_coordinator) - ["inspections", "appointments", "bids"]
      when "Crew"
        the_role = (general + office_processing + proj_coordinator + proj_coordinator) - ["proj_scheds"]
      when "Executive Staff"
        the_role = []
      end
    the_role
  end
end
