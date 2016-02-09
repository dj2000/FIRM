Rails.application.routes.draw do

  TheRoleManagementPanel::Routes.mixin(self)
  resources :draftsmen
  resources :project_payment_schedules do
    get :load_project_payment_schedules, on: :collection
  end

  resources :credit_notes
  resources :engineers
  resources :permit_informations do
    get :send_email, on: :collection
    get :load_email_template, on: :member
  end

  resources :commissions do
    get :process_commissions, on: :collection
    get :print, on: :collection
    get :calculation_of_inspector_commissions, on: :collection
  end

  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :insp_comm_scales

  resources :proj_insps do
    get :print, on: :collection
  end

  resources :permits do
    get :print, on: :collection
  end

  resources :crew_skills

  resources :crews do
    get :print, on: :collection
    get :report, on: :collection
    get :crew_report, on: :collection
    get :crew_report_print, on: :collection
  end

  resources :commission_rates do
    get :print, on: :collection
  end

  resources :proj_scheds do
    get :scheduled_projects, on: :collection
    get :report, on: :collection
    get :print, on: :collection
  end

  resources :projects do
    get :print, on: :collection
    get :send_email_to_crew, on: :member
  end

  resources :pmt_schedules do
    get :print, on: :collection
  end

  resources :contracts do
    get :report, on: :collection
    get :report_result, on: :collection
    get :print, on: :collection
  end

  resources :comm_histories do
    get :bid_info, on: :member
    post :mark_complete, on: :collection
  end

  resources :pay_plans do
    get :print, on: :collection
  end

  resources :bids do
    get :report, on: :collection
    get :print, on: :collection
  end

  match "/block_out_periods/new/:appointment_id" => "block_out_periods#new", via: :get
  resources :block_out_periods

  resources :inspections do
    get :appointment_info, on: :member
    get :print, on: :collection
    get :report, on: :collection
    get :report_result, on: :collection
    get :send_email, on: :member
    delete :delete_attached_file, on: :member
  end

  resources :receipts do
    get :invoice_info, on: :member
    get :report, on: :collection
    get :report_result, on: :collection
    get :print, on: :collection
  end

  resources :invoices do
    get :update_collection, on: :member
    get :info, on: :member
    get :report, on: :collection
    get :get_report, on: :collection
    get :print, on: :collection
  end

  resources :i_fee_schedules do
    get :print, on: :collection
  end

  resources :skills

  resources :insp_skills

  resources :inspectors do
    get :print, on: :collection
  end

  resources :svc_areas do
    get :print, on: :collection
  end

  resources :svc_criteria do
    get :print, on: :collection
  end

  resources :appointments do
    get :get_scheduled_appointments, on: :collection
    get :print, on: :member
    get :send_email, on: :member
    get :calculate_inspection_fee, on: :member
    get :background_events, on: :collection
    get :report, on: :collection
    get :report_print, on: :collection
  end

  resources :insp_requests do
    get :get_property_clients, on: :collection
    get :get_client_agents, on: :collection
    get :insp_request_info, on: :member
  end


  resources :agent_clients

  resources :client_properties

  resources :properties do
    get :map, on: :collection
    get :get_map, on: :collection
    get :print, on: :collection
  end

  resources :agents do
    get :report, on: :collection
    get :print, on: :collection
  end

  resources :clients do
    get :report, on: :collection
    get :print, on: :collection
  end

  resources :users, only: [:index, :update] do
    get :change_status, on: :member
  end

  match "/page/operating_statistics_report" => "page#operating_statistics_report", as: "operating_statistics_report", via: :get

  match "/page/statistics" => "page#statistics", via: :get
  match "/page/print" => "page#print", via: :get

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root  to: 'page#index'

  get '/cities' => 'application#cities'

  resources :documents, only: [:destroy]

end
