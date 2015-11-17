Rails.application.routes.draw do

  resources :credit_notes

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
  end

  resources :commission_rates do
    get :print, on: :collection
  end

  resources :proj_scheds do
    get :scheduled_projects, on: :collection
    get :report, on: :collection
  end

  resources :projects do
    get :print, on: :collection
  end

  resources :pmt_schedules do
    get :print, on: :collection
  end

  resources :contracts

  resources :comm_histories

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
  end

  resources :receipts do
    get :invoice_info, on: :member
  end

  resources :invoices do
    get :update_collection, on: :member
    get :info, on: :member
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

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root  to: 'page#index'

  get '/cities' => 'application#cities'

end
