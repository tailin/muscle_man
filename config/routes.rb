Rails.application.routes.draw do
  
  root to: "practices#index"

  resources :practices do
    collection do
      post :search
      get :search
    end
  end  

  resources :users do
    collection do
      get :line_login
      post :line_login
      get :auth
    end
  end
end
