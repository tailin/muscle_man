Rails.application.routes.draw do
  root to: "practices#index"

  resources :practices do
    post :search, on: :collection
    get :search, on: :collection
  end  

  # match "/^[^(\/liff_entry){1}]", to: "practices#webhook", via: [:get, :post]
end
