module V1
  module Resources
    module Follows
      class User < Grape::API
        format :json

        resource :user_follows do
          desc "Returns list of followed users"
          get "/list" do
            generate_response(::Users::ActorGetDetailService.new(params[:id]).call)
          end

          desc "Add user to follow"
          params do
            requires :id, type: String, desc: "User's id to follow"
          end
          post "/add" do
            generate_response(::Users::ActorGetDetailService.new(params[:id]).call)
          end

          desc "Remove followed user"
          params do
            requires :id, type: String, desc: "User's id to unfollow"
          end
          post "/remove" do
            generate_response(::Users::ActorCreateService.new(name: params[:name]).call)
          end
        end
      end
    end
  end
end
