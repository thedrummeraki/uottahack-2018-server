Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # GET routes
  get "/api/tickets/current" => "auth_api#current_number"
  get "/api/tickets/average/wait-time" => "auth_api#wait_time"

  # POST modifier URLs
  post "/api/tickets/new" => "auth_api#add_ticket"
  post "/api/tickets/next" => "auth_api#increment_ticket"
  post "/api/tickets/cancel" => "auth_api#cancel_ticket"
  
  post "/api/new/token" => "api#new_auth_token"
end
