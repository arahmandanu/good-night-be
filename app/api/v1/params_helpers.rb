module V1
  module ParamsHelpers
    extend Grape::API::Helpers

    params :pagination_params do |options|
      optional :page, type: Integer, desc: "Page number", default: 1
      optional :per_page, type: Integer, desc: "Items per page", default: 10
    end

    params :date_ranges do |options|
      optional :start_date, type: Date, desc: "Start date"
      optional :end_date, type: Date, desc: "End date"
    end
  end
end
