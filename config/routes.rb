Rails.application.routes.draw do
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

  resource :dashboard, only: %i[show]

  resources :users, only: %i[show edit update]

  resources :journals, only: %i[new create index edit update destroy] do
    resources :notes, shallow: true do
      resources :comments, shallow: true
      resources :counters, shallow: true do
        member do
          patch "increment"
          patch "decrement"
        end
      end
    end
  end

  resources :campaigns do
    resources :invitations, only: %i[new create index],
      controller: "campaigns/invitations"
    resources :membership_journals, only: %i[new create]
  end

  resources :membership_journals, only: %i[destroy]

  resources :invitations, only: %i[destroy]

  namespace :users do
    resources :invitations, only: %i[index show] do
      post :accept, on: :member
    end
  end

  resources :memberships, only: %i[destroy]

  resources :notifications, only: %i[index destroy]
end
