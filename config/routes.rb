Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  devise_for :customers, path:"", controllers: {
  sessions:      'customers/sessions',
  passwords:     'customers/passwords',
  registrations: 'customers/registrations'
  
}

  devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
}

namespace :admins do
    resources :items, only: [:show, :update, :new, :edit, :index, :create]
    resources :confirmations, only: [:new]
    resources :customers, only: [:show, :index, :edit, :update]
    resources :genres, only: [:index, :edit, :update, :create]
    resources :homes, only: [:top]
    resources :orders, only: [:show, :update, :index]
    resources :order_details, only: [:update]
    get '/admin/sign_out' => 'devise/sessions#destroy'
end

get 'admin' => 'admins/homes#top'

scope module: :customers do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    get 'explanation' => 'homes#explanation'
    resources :items, only: [:index, :show]
    get 'search' => 'items#search'
    resource :customers, only: [:edit, :update]
    get 'customers/my_page' => 'customers#my_page'
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch 'customers/withdrawal' => 'customers#withdrawal'
    put 'customers/withdrawal' => 'customers#withdrawal'
    resources :cart_items, only: [:index, :update, :create, :destroy] do
      collection do
        delete 'destroy_all'
      end
    end
    get 'orders/thank' => 'orders#thank'
    post 'orders/verification' => 'orders#verification'
    resources :orders, only: [:new, :index, :show, :create]
    resources :addresses, only: [:index, :edit, :update, :create, :destroy]
  end
end
