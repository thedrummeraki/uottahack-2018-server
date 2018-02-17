Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/api/get/current" => "api#current_number"
  get "/api/get/average/wait-time" => "api#wait_time"
  
  post "/api/new/token" => "api#new_auth_token"
end
