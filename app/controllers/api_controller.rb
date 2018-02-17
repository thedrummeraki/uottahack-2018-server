class ApiController < ApplicationController

    protect_from_forgery with: :null_session

    def new_auth_token
        client_ip = request.remote_ip
        client_session = ClientSession.create_or_get client_ip
        render json: {
            success: true,
            auth_token: client_session.auth_token
        }
    end

    def not_found
        respond_with '{"success": false, "reason": "404 not found.", message: "The request page on the API server was not found."}'
    end

end
