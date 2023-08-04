Rails.application.routes.draw do
  get "journals/new"
  # Authentication
  devise_for :users

  # Root path
  devise_scope :user do
    authenticated :user do
      root to: redirect("journals/new")
    end

    unauthenticated :user do
      root "static_pages#splash", as: :unauthenticated_root
    end
  end

  get "/about/", to: "static_pages#about"

  resources :journals, only: %i[new create index]

  resources :notes, only: %i[new create index]
end
