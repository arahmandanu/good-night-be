module V1
  module Resources
    module SleepsHistories
      class SleepsHistories < Grape::API
        helpers V1::ParamsHelpers

        resource :sleeps_histories do
          desc "Actor do clock in"
          params do
            use :pagination_params
            use :date_ranges
          end
          get "/:user_id/me" do
            generate_response(::SleepsHistories::ActorGetListService.new(params).call)
          end

          desc "Actor do clock out"
          params do
            use :pagination_params
            use :date_ranges
          end
          get "/:user_id/followed" do
            generate_response(::SleepsHistories::ActorGetListFollowedService.new(params).call)
          end
        end
      end
    end
  end
end
