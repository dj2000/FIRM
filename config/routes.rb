Rails.application.routes.draw do

  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :insp_comm_scales

  resources :commissions

  resources :proj_insps

  resources :permits

  resources :crew_skills

  resources :crews

  resources :proj_scheds do
    get :scheduled_projects, on: :collection
  end

  resources :projects

  resources :pmt_schedules

  resources :contracts

  resources :comm_histories

  resources :pay_plans

  resources :bids

  resources :inspections do
    get :appointment_info, on: :member
  end

  resources :receipts do
    get :invoice_info, on: :member
  end

  resources :invoices do
    get :update_collection, on: :member
    get :info, on: :member
  end

  resources :i_fee_schedules

  resources :skills

  resources :insp_skills

  resources :inspectors

  resources :svc_areas

  resources :svc_criteria

  resources :appointments do
    get :get_scheduled_appointments, on: :collection
    get :print, on: :member
    get :send_email, on: :member
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
  end

  resources :agents

  resources :clients

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root  to: 'page#index'

  get '/cities' => 'application#cities'

end
