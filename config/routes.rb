# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#index'
  resources :pages, only: [:index]
  resources :cards
  post 'check_card', to: 'pages#check_card'
end
