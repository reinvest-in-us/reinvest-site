Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :police_districts, except: %i[destroy] do
      resources :meetings, except: %i[show]
      resources :elected_officials, except: %i[show destroy]
    end
    root to: 'police_districts#index'
  end

  resources :police_districts, only: [:index]
  get '/d/:slug', to: 'police_districts#show', as: :police_district

  get '/about', to: 'static_pages#about', as: :about
  root to: 'police_districts#index'
  get '/404', to: 'static_pages#page_not_found'
end
