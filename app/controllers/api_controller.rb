class ApiController < ApplicationController

    def new_auth_token
        client_ip = request.remote_ip
        client_session = ClientSession.create_new
        auth_token = client_session.nil? ? nil : client_session.auth_token
        render json: {
            success: !client_session.nil?,
            auth_token: auth_token
        }
    end

    def not_found
        respond_with '{"success": false, "reason": "404 not found.", message: "The request page on the API server was not found."}'
    end

end
