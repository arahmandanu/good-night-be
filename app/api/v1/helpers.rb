module V1
  module Helpers
    extend Grape::API::Helpers
    include ActiveSupport

    def generate_response(data)
      if data.failure?
        status = 422
        if data.error.class == Dry::Validation::Result
          message = data.error.errors.to_h
        elsif data.error.class == String
          message = data.error
        end

        error_response(status: status, message: message)
      else
        response = if data.value.is_a?(String)
          data.value
        else
          data.value.to_h
        end

        success_response(response)
      end
    end

    def success_response_paginate(response, status: 200, message: "Success")
      present({
        message: message,
        data: response.value[:data],
        meta: response.value[:meta]
      })
    end

    def success_response(data, status: 200, message: "Success")
      present({
        message: message,
        data: data
      })
    end

    def error_response(status: 400, message: "Error")
      present({
        status: status,
        message: message,
        errors: true
      }, status: status)
    end
  end
end
