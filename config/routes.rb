Rails.application.routes.draw do

 

  resources :subscriptions


  get "/subscriptions/:id" => "subscriptions#show"
  # post "/hook" => "subscriptions#hook"
  
  resources :plans do
    collection { post :import }
    resources :subscriptions
  end
  get '/users' => "users#index"

  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :admins
  devise_for :users, controllers: {
         # registrations: 'users/registrations',
        :omniauth_callbacks => "omniauth_callbacks"
      }

  
  get 'profiles/edit'

  resources :rules do
    collection { post :import }
  end
  resources :profiles
  resources :amenities do
    collection { post :import }
  end
  resources :listings

  resources :cities do
    collection { post :import }
  end
  resources :admin_listings do
    collection { post :import }
  end
  resources :areas do
    collection { post :import }
  end

  resources :home
 
  get "/destroy_multiple_messages" => "user_dashboard#destroy_message"
  get "/destroy_messages" => "dashboard#destroy_message"
  
  put "like" => "listings#upvote", as:'like_listing'
  put "dislike" => "listings#downvote",as:'dislike_listing'


  get '/listing/:id' => "home#show" , as:'show_listing'

  get '/update_areas' => "areas#area_list", :as => 'update_areas'
 
 
  get 'user_dashboard' => 'user_dashboard#index'
  get 'user_messages' => 'user_dashboard#messages'
  get 'show_message/:id' => 'user_dashboard#show_message'
  get 'favorites' => 'user_dashboard#favorites'


  get 'adminsubscriptions' => 'dashboard#subscriptions', as: 'adminsubscriptions'

  get '/admin' => 'dashboard#index'

  delete '/delpic' => "listings#delpic"

  delete '/dellistingpic' => "admin_listings#delpic"

   get 'user_dashboard'  => "user_dashboard#index", as: 'user_profile'


   get '/change_listing_status' => "admin_listings#change_listing_status"
   get '/change_plan_status' => "plans#change_plan_status"

   get '/messages' => "dashboard#messages"

   patch '/update_password' => "user_dashboard#update_password", as: 'update_password'
    get '/update_settings' => "profiles#update_settings"

   get '/listings_json' => "home#listings_json" 
   get '/areas_json' => "home#areas_json" 
   get '/cities_json' => "home#cities_json" 
   get '/amenities_json' => "home#amenities_json" 
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'home#index'

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
