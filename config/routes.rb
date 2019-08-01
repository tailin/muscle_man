Rails.application.routes.draw do
  root to: "practices#index"

  resources :practices
end
