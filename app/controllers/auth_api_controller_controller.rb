class AuthApiControllerController < ApplicationController

  before_action :check_auth_token

  private

  def check_auth_token
    auth_token = params[:auth_token]
    if auth_token.nil?
      render json: {
          success: false,
          message: 'Please refer to the documentation at https://github.com/thedrummeraki/uottahack-2018-server.',
          reason: 'Missing authentication token.'
      }
      return
    end

    response = {}
    unless ClientSession.exists auth_token
      render json: {
          success: false,
          reason: 'The provided token does not exist anymore.',
          message: 'Please refer to the documentation at https://github.com/thedrummeraki/uottahack-2018-server.'
      }
    end
  end
end
