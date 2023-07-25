Rails.application.routes.draw do
  # Authentication
  devise_for :users

  # Root path
  devise_scope :user do
    authenticated :user do
      root to: redirect("campaigns/new")
    end

    unauthenticated :user do
      root "static_pages#splash", as: :unauthenticated_root
    end
  end

  resources :campaigns, only: %i[new]

  resources :notes, only: %i[new index]
end
