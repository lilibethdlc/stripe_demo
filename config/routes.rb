Rails.application.routes.draw do
  root 'home#index'

  get 'home#custom', to: 'home#custom', as: :custom

  post 'charge_index', to: 'home#charge_index', as: :charge_index
  post 'charge_custom', to: 'home#charge_custom', as: :charge_custom
end
