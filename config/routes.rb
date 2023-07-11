Rails.application.routes.draw do
  root "rails/welcome#index"
  devise_for :users
  resources :notes, only: %i[index]
end
