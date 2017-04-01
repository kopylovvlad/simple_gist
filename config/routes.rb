Rails.application.routes.draw do
  # see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :gists
  get 'users/login/:user_login', to: 'users#show', as: :user
  root to: 'home#main'

  get '*unmatched_route', to: 'application#render_not_found'
  get '/500', to: 'application#render_error'
end
