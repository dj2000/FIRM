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
        new_role.save!
      end
      binding.pry
    end
  end

  def get_permission(role)
    denied_permission = {}
    roles = get_role(role)
    roles.each do |role|
      hash = {"index" => false }
      denied_permission[role] = hash
    end
    denied_permission
  end

  def get_role(role)
    case role
      when "Inspection coordinator"
        the_role = ["svc_criteria", "i_fee_schedules","commission_rates",
          "commissions", "crews","inspections","pay_plans",
          "invoices","receipts","credit_notes","bids","permits",
          "proj_insps","comm_histories","contracts","projects","proj_scheds"]
      end
    the_role
  end

end
