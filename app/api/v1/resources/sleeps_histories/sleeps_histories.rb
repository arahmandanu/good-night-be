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
          get "/:id/me" do
            generate_response(::Sleeps::ActorClockInService.new(params[:user_id]).call)
          end

          desc "Actor do clock out"
          params do
            use :pagination_params
            use :date_ranges
          end
          get "/:id/followed" do
            generate_response(::Sleeps::ActorClockOutService.new(params[:user_id], params[:sleep_id]).call)
          end
        end
      end
    end
  end
end
