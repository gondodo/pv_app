Rails.application.routes.draw do
    resources :impression, only: :create
    resources :analytics, only: :index
end
