Rails.application.routes.draw do
  resources :fibs
  root to: 'fibs#index'
  mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)
end
