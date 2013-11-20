Whenitopen::Application.routes.draw do
  devise_for :admins

  get "/aboutus" => 'home#aboutus', :as => :aboutus

  get "/contactus" => 'home#contactus', :as => :contactus

  post "/contact" => 'home#contact', :as => :contact

  get "/terms_and_conditions" => 'home#terms_and_conditions', :as => :terms_and_conditions
  root :to => "businesses#index"

  resources :businesses do
    collection do
      get :search
      get :city_businesses
      get :csv
      get :cities
      get :pending_businesses
    end
    member do
      put :confirm_business
    end
  end
  resources :imports do
    collection do
      get :import
      get :add_recent_business
      post :create_recent_business
      post :upload_xls
      get :delete_business
      get :delete_all_by_business_name
    end
  end
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
