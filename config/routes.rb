Rails.application.routes.draw do
    resources :impression, :only => [:index, :create]
end
