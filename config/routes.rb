Rails.application.routes.draw do
  resources :trackers
  resources :questions
  resources :subgenres
  resources :genres
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {registrations: "users/registrations"}
  get 'home/index'
  root 'home#index'

  get 'genres/:genre_id/subgenres', to: 'subgenres#index', as: 'subgenres_link'
  get 'subgenres/:subgenre_id/questions', to: 'questions#index', as: 'questions_link'
  get 'trackers/leaderboard/:subgenre_id', to: 'trackers#leader'
  get 'reset/subgenres', to: 'subgenres#reset' , as: 'subgenre_reset_link'
  # get 'subgenres/:subgenre_id/questions/reset', to: 'subgenres#reset', as: 'questions_reset_link'

  match '*path' => redirect('/'), via: :get
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
