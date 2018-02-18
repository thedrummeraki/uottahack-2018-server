Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # GET routes
  get "/api/tickets/current" => "auth_api#current_number" # OK
  get "/api/tickets/wait-time" => "auth_api#wait_time" # OK

  # POST modifier URLs
  post "/api/tickets/new" => "auth_api#add_ticket" # OK
  post "/api/tickets/next" => "auth_api#increment_ticket" # OK
  post "/api/tickets/cancel" => "auth_api#cancel_ticket" # OK
  
  post "/api/new/token" => "api#new_auth_token" # OK
end
