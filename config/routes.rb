Rails.application.routes.draw do
  root to: "practices#index"

  # post "/webhook", to: "practices#webhook"
  resources :practices
  # get "/:message", to: "practices#webhook"

  # match "/^[^(\/liff_entry){1}]", to: "practices#webhook", via: [:get, :post]
end
