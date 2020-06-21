Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :police_districts do
      resources :meetings
      resources :elected_officials
    end
    root to: 'police_districts#index'
  end

  resources :police_districts, only: [:index]
  get '/d/:slug', to: 'police_districts#show', as: :police_district

  get '/about', to: 'static_pages#about', as: :about
  root to: 'police_districts#index'
end
