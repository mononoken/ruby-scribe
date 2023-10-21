Rails.application.routes.draw do
  get "invitations/new"
  get "invitations/create"
  # Authentication
  devise_for :users, controllers: {registrations: "users/registrations",
                                   sessions: "users/sessions"}

  # Root path
  devise_scope :user do
    authenticated :user do
      root to: redirect("dashboard")
    end

    unauthenticated :user do
      root "static_pages#splash", as: :unauthenticated_root
    end
  end

  get "about", to: "static_pages#about"

  get "dashboard", to: "users#show", as: :dashboard

  resources :journals, only: %i[new create index edit update destroy] do
    resources :notes, shallow: true
  end

  resources :collections, only: %i[new create index show] do
    resources :invitations, only: %i[new create index]
  end

  resources :invitations, only: %i[destroy]
end
