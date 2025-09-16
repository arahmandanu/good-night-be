module V1
  module Helpers
    extend Grape::API::Helpers
    def generate_response(data)
      if data.failure?
        if data.error.class == Dry::Validation::Result
          status = 422
          message = "Validation Failed"
          errors = data.error.errors.to_h
        end

        error_response(errors: errors, status: status, message: message)
      else
        success_response(data.to_h)
      end
    end

    def success_response(data, status: 200, message: "Success")
      present({
        status: status,
        message: message,
        data: data
      }, status: status)
    end

    def error_response(errors: nil, status: 400, message: "Error")
      present({
        status: status,
        message: message,
        errors: errors
      }, status: status)
    end
  end
end
