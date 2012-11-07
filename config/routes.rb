Senate2::Application.routes.draw do
  post "tag/tag"

  get "tag/untag/:tag", :controller => 'tag', :action => 'untag'

  get "tag/tagged/:tag", :controller => 'tag', :action => 'tagged'
  get "tagged/:tag", :controller => 'tag', :action => 'tagged'

  resources :assemblies

	get "comments/create"

	get "home/index"

	resources :news_items
	

	resources :chambers do
		resources :comments do
			resources :comments
		end
		resources :events do
			member do
				get 'attend'
				get 'unattend'
			end
		end
		resources :titles do
			member do
				post 'change'
			end
		end
		resources :proposals do 
			resources :permissions
			resources :comments
			member do
				get 'close'
				post 'vote'
				get 'cancel'
				get 'inspect'
			end
		end
		resources :boards do
			resources :permissions
			resources :comments
			member do 
				post 'comment'
				get 'discuss'
			end
		end
		resources :ballots do
			resources :permissions
			member do 
				get 'close'
				post 'vote'
				get 'cancel'
				get 'inspect'
			end
		end
		resources :permissions
		resources :announcements do
			resources :comments
			member do
				get 'discuss'
			end
		end
		member do
			post 'announce'
		end
	end
	resources :groups do
		member do
			post :change
		end
	end


	post "sessions/create"

	resources :users

	get "sessions/new"

	match "sessions/destroy"

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
	root :to => 'home#index'

	# See how all your routes lay out with "rake routes"

	# This is a legacy wild controller route that's not recommended for RESTful applications.
	# Note: This route will make all actions in every controller accessible via GET requests.
	# match ':controller(/:action(/:id))(.:format)'
end
