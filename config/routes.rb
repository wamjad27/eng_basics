Rails.application.routes.draw do
  resources :fibs
  root to: 'fibs#index'
end
