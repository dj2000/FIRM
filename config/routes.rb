Rails.application.routes.draw do

  devise_for :users
  resources :insp_comm_scales

  resources :commissions

  resources :proj_insps

  resources :permits

  resources :crew_skills

  resources :crews

  resources :proj_scheds

  resources :projects

  resources :pmt_schedules

  resources :contracts

  resources :comm_histories

  resources :pay_plans

  resources :bids

  resources :inspections

  resources :receipts

  resources :invoices

  resources :i_fee_schedules

  resources :skills

  resources :insp_skills

  resources :inspectors

  resources :svc_areas

  resources :svc_criteria

  resources :appointments

  resources :insp_requests

  resources :agent_clients

  resources :client_properties

  resources :properties

  resources :agents

  resources :clients

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  root  to: 'page#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
