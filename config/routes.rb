Kinohive::Application.routes.draw do

  resources :awarding_hivecoins

  resources :statistics

  resources :videos do
      collection do
   	 match 'search' => 'videos#search', :via => [:get, :post] , :as => :search
      end
  end

	match "/auth/:provider/callback" => "sessions#create"
	match "sessions/new" => "sessions#new"
	match '/signup', to: 'users#new'	
	match "/auth/failure" => "sessions#failure"
	match "/signout" => "sessions#destroy", :as => :signout

	match 'awarding_hivecoin', :controller => 'AwardingHivecoins', :action => 'awarding_hivecoin'

  devise_for :admins

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

	resources :identities
	
		resources :users do
		collection do
			put 'reset'
		end
	end 

	match '/user_profile', to:  'users#user_profile'
	match '/user_videos' => 'users#user_videos'
	match '/user_hivecoins' => 'users#user_hivecoins'
	match '/user_contributed_videos' => 'users#user_contributed_videos'
	match '/update_password' => 'users#update_password'
	match 'change_password' => 'users#change_password'
#	match 'reset' => 'users#reset'
	match 'forgotpass' => 'users#forgotpass'
	match 'changepass' => 'users#changepass'
	match 'change' => 'users#change'




#	match 'user_profile', :controller => 'users', :action => 'user_profile'

	

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
   root :to => 'videos#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
