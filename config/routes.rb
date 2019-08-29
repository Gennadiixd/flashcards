# frozen_string_literal: true

Rails.application.routes.draw do
    root 'pages#index'
    resources :pages
    resources :cards
end
