namespace :role do
  desc "TODO"
  task user_role: :environment do
   create_role
  end

  def create_role
    roles = {
      "Super Admin" => "This User Access to Whole system",
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
        the_role = role == "Super Admin" ? get_role(role) : get_permission(role)
        if role == "Inspection coordinator"
          process_commission = { "commissions" => {"process_commissions" => true }}
          new_role.the_role = the_role.merge(process_commission)
        elsif ["Exec director","Project Coordinator"].include?(role)
          the_role["commissions"] ["process_commissions"] = false
          new_role.the_role = the_role
        else
          new_role.the_role = the_role
        end
        new_role.save
      end
    end
    puts "------ Role Created Successfully ---------"
  end

  def get_permission(role)
    denied_permission = {}
    roles = get_role(role)
    roles.each do |role|
      temp = {}
      controller_action = eval(role.camelize + "Controller").action_methods
      actions = (controller_action - ApplicationController.action_methods).to_a
      actions.map {|action| temp[action] = true }
      denied_permission[role] = temp
    end
    denied_permission
  end

  def get_role(role)
    general = ["svc_criteria", "i_fee_schedules", "commission_rates", "commissions", "svc_areas", "inspectors", "crews"]
    insp_coordinator = ["insp_requests", "properties", "clients", "agents", "appointments", "block_out_periods"]
    office_processing = ["inspections","pay_plans", "invoices","receipts","credit_notes","permits","bids","permits", "proj_insps"]
    proj_coordinator = ["comm_histories","contracts","projects","proj_scheds"]
    super_admin = {:system => { :administrator => true }}
    case role
      when "Inspection coordinator"
        the_role = insp_coordinator +  ["svc_areas", "inspectors"]
      when "Exec director"
        the_role = office_processing + general
      when "Project Coordinator"
        the_role = office_processing + general + proj_coordinator + ["crews"]
      when "Inspector"
        the_role = ["inspections", "appointments", "bids"]
      when "Crew"
        the_role = ["proj_scheds"]
      when "Executive Staff"
        the_role = general + insp_coordinator + office_processing + proj_coordinator
      when "Super Admin"
        the_role = super_admin
      end
    the_role
  end
end
