require 'resque_web'

Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config

  authenticate :admin_user do
    mount ResqueWeb::Engine => '/resque_web'
  end

  ActiveAdmin.routes(self)
  devise_for :users
  root to: 'home#index'

  resources :user_infos, only: [:update]
  get 'user_info/edit' => 'user_infos#edit'

  get 'opportunities' => 'auctions#opportunities_index'
  get 'opportunities/:id' => 'auctions#show_opportunity', as: 'show_opportunity'

  post 'arenda/get_bidders_counter' => 'auctions#get_bidders_counter'
  post 'arenda/update_subcategories' => 'auctions#update_subcategories'
  post '/get_bidders_counter' => 'auctions#get_bidders_counter'
  post '/update_subcategories' => 'auctions#update_subcategories'

  resources :auctions, except: [:edit, :update, :new]
  get 'arenda/:category_slug' => 'auctions#new', constraints: { category_slug: /\w+/ }

  resources :bids, only: [:create, :new]

  resources :mechanisms

  get 'info/' => 'articles#index', as: 'infos_index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
