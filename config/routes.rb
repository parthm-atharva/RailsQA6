Rails.application.routes.draw do
  resources :answers
  resources :topics
  resources :questions
  get 'home/index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  post '/follow_user/:id', to: 'follows#follow_user', as: 'follow_user'
  post '/follow_topic/:id', to: 'follows#follow_topic', as: 'follow_topic'

  post '/post_answer/:id', to: 'questions#post_answer', as: 'post_answer'
end
