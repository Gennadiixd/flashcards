# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#index'
  resources :pages, only: [:index]
  resources :cards
  post 'check_card', to: 'cards#check_card'
end
