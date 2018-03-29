class ApiController < ActionController::API
  before_action :api_key_validation

  private

    def api_key_validation
      not_found = {message: "Unauthorized"}
      unless User.find_by(id: request.headers["X-API-KEY"])
        render json: not_found, status: 401
      end
    end
end
