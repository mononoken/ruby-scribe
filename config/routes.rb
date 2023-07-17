Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root "notes#index"
    end

    unauthenticated :user do
      root "static_pages#splash", as: :unauthenticated_root
    end
  end

  resources :notes, only: %i[new index]
end
