class ApplicationController < ActionController::Base
  def authenticate!
    authentication_token = request.headers['x-api-key']
    server_name = request.headers['x-server-name']
    unless authentication_token && server_name
      render text: 'Unauthorized', status: 401
      return
    end

    c = TokenService.new(server_name: server_name)

    render text: 'Unauthorized', status: 401 unless c.valid_token?(token: authentication_token)
  end
end
