require 'resque_web'

Rails.application.routes.draw do
  
  devise_for :admin_users, ActiveAdmin::Devise.config

  authenticate :admin_user do
    mount ResqueWeb::Engine => '/resque_web'
  end

  ActiveAdmin.routes(self)
  devise_for :users

  root to: 'home#index'

  resources :user_infos, only: [:update, :show]
  get 'user_info/edit' => 'user_infos#edit', as: 'edit_profile'

  get 'opportunities' => 'auctions#opportunities_index'
  get 'opportunities/:id' => 'auctions#show_opportunity', as: 'show_opportunity'


  # Dynamic data on auction create form.
  post 'arenda/get_bidders_counter' => 'auctions#get_bidders_counter'
  post 'arenda/update_subcategories' => 'auctions#update_subcategories'
  post '/get_bidders_counter' => 'auctions#get_bidders_counter'
  post '/update_subcategories' => 'auctions#update_subcategories'

  # Auction basic routes.
  resources :auctions, except: [:edit, :update, :new]
  get 'arenda/:category_slug' => 'auctions#new', constraints: { category_slug: /(\w|-)+/ }, as: 'new_arenda'

  # Auctions for unregistered users.
  get 'bystraia-arenda/:category_slug' => 'auctions#new_unregistered', constraints: { category_slug: /(\w|-)+/ }, as: 'quick_new_arenda'
  post 'bystraia-arenda/' => 'auctions#create_unregistered'

  resources :bids, only: [:create, :new]

  resources :mechanisms

  get 'info/' => 'articles#index', as: 'infos_index'

  resources :feedbacks, only: [:create, :new]
end
