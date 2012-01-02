Senate::Application.routes.draw do
  resources :ballot_remarks

  get 'ballots/close'
  
  resources :ballots do
	resources :ballot_remarks
  end

  resources :proposal_remarks

  get 'proposals/close'
  get 'proposals/ajax_all'
  
  resources :proposals do
	resources :proposal_remarks
  end

  resources :titles

  resources :boards

  resources :comments
  
  resources :announcements

  resources :news_items

  get 'permissions/ajax_update_principals'
  resources :permissions

  get 'principals/matrix'
  
  resources :principals

  resources :chambers do
	resources :permissions
	resources :principals
	resources :announcements
	resources :boards
	resources :titles
	resources :proposals
	resources :ballots
  end
  
  get 'sessions/destroy'
  get "sessions/override"
  get "sessions/cancel_override"  
  resources :sessions

  get 'groups/matrix'
  
  resources :groups

  resources :users

  get "home/index"

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
   root :to => "home#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
   #match ':controller(/:action(/:id(.:format)))'
end
