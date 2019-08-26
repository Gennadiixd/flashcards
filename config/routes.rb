Rails.application.routes.draw do
root 'pages#index'
get 'all_cards' => 'pages#all_cards'
get 'add_card' => 'pages#add_card'
end
