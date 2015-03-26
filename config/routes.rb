Rails.application.routes.draw do
  root 'home#index'

  post 'charge', to: 'home#charge', as: :charge
end
