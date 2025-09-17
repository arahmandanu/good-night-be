module V1
  module Resources
    module Sleeps
      class Sleeps < Grape::API
        resource :sleeps do
          desc "Actor do clock in"
          params do
            requires :user_id, type: String, desc: "User's id"
          end
          post :clock_in do
            generate_response(::Sleeps::ActorClockInService.new(params[:user_id]).call)
          end

          desc "Actor do clock out"
          params do
            requires :user_id, type: String, desc: "User's id"
            requires :sleep_id, type: String, desc: "Sleep id"
          end
          post :clock_out do
            generate_response(::Sleeps::ActorClockOutService.new(params[:user_id], params[:sleep_id]).call)
          end
        end
      end
    end
  end
end
