Team::Application.routes.draw do

  resources :questions do |question|
    resources :qanswers
  end
  match 'question' => 'questions#index'


  devise_for :admins, controllers: {
        sessions: 'admins/sessions',
        registrations: 'admins/registrations',
        confirmations: 'admins/confirmations',
        passwords: 'admins/passwords',
        unlocks: 'admins/unlocks'
      }


  root :to => 'index#index'
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations',
        confirmations: 'users/confirmations',
        passwords: 'users/passwords',
        unlocks: 'users/unlocks'
      }
  match '/admins/index' => 'admins/admins#index'
  match 'admins/usrmgmt/:id' => 'admins/admins#usrmgmt'
  match 'admins/actmgmt' =>'admins/admins#actmgmt'
  match 'admins/svcmgmt' =>'admins/admins#svcmgmt'
  match 'admins/sndemail' =>'admins/admins#sndemail'

  match 'admins/ad_cnfm/:id' =>'admins/admins#cnfm', :as => "ad_cnfm"
  match 'users/index' =>'users/users#index'
  match 'users/registration' => 'users/users#regist'
  match 'users/show/:alt' => 'users/users#show'
  #


  #match 'index' =>'index#index'
  resources :activities
  match 'activities/:string/page/:id' => 'activities#list'
  match 'activities/:id/newQuestion' => 'activities#newQuestion'
  match 'activities/:id/newReply' => 'activities#newReply'
  match 'activities/:id/newComment' => 'activities#newComment'



  #match 'signin' => 'users#signin'
  #match 'signinChk' => 'users#signinChk' , :via => 'post'
  #match 'logout' =>'users#logout'


  match 'hitmap' => 'hitmap#index'


  #resources :outservices
  match 'outservices',:to =>'outservices#index' , :via =>'get', :as=>'outservices'


  match 'outservices/new',:to =>'outservices#new_outservice' , :via =>'get', :as=>'new_outservice'
  match 'outservices',:to =>'outservices#create_outservice' , :via =>'post'
  match 'outservices/:service_kind/:name',:to =>'outservices#delete_outservice' , :via =>'delete', :as=>'delete_outservice'
  match 'outservices/:service_kind/:name',:to =>'outservices#show_outservice' , :via =>'get', :as=>'show_outservice'

  match 'outservices/:service_kind/:name',:to =>'outservices#add_outservice_comments' , :via =>'post', :as=>'add_outservice_comments'
  match 'outservices/:service_kind/:name/:nickname/:comment',:to =>'outservices#delete_outservice_comments' , :via =>'delete', :as=>'delete_outservice_comments'


  #match 'outservices/restaurant/new',:to =>'outservices#new_restaurant' , :via =>'get', :as=>'new_restaurant'
  #match 'outservices',:to =>'outservices#create_restaurant' , :via =>'post'
  #match 'outservices/restaurant/:name',:to =>'outservices#show_restaurant' , :via =>'get', :as=>'restaurant'
  match 'outservices/restaurant/:name',:to =>'outservices#update_restaurant' , :via =>'put', :as=>'put_restaurant'
  #match 'outservices/restaurant/:name',:to =>'outservices#delete_restaurant' , :via =>'delete', :as=>'delete_restaurant'
  match 'outservices/restaurant/:name/edit',:to =>'outservices#edit_restaurant' , :via =>'get', :as=>'edit_restaurant'

  #match 'outservices/restaurant/:name',:to =>'outservices#show_restaurant_comments' , :via =>'get', :as=>'restaurant_comments'
  #match 'outservices/restaurant/:name',:to =>'outservices#add_restaurant_comments' , :via =>'post', :as=>'add_restaurant_comments' 
  #match 'outservices/restaurant/:name/:nickname/:comment',:to =>'outservices#delete_restaurant_comments' , :via =>'delete', :as=>'delete_restaurant_comments'



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
