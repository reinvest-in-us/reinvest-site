Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :police_districts, only: [:index, :new, :create]
    root to: 'police_districts#index'
  end

  resources :police_districts, only: [:index]
  get '/d/:slug', to: 'police_districts#show', as: :police_district

  root to: 'police_districts#index'
end
