module V1
  module Resources
    module Follows
      class User < Grape::API
        helpers V1::ParamsHelpers

        resource :user_follows do
          desc "Returns list of followed users"
          params do
            use :pagination_params
            requires :user_id, type: String, desc: "Actor id"
          end

          get "/list" do
            generate_response(::Follow::ActorListFollowedService.new(params: params).call)
          end

          desc "Add user to follow"
          params do
            requires :user_id, type: String, desc: "Actor id "
            requires :followed_id, type: String, desc: "User's id to follow"
          end
          post "/add" do
            generate_response(::Follow::ActorAddFollowService.new(user_id: params[:user_id], followed_id: params[:followed_id]).call)
          end

          desc "Remove followed user"
          params do
            requires :user_id, type: String, desc: "Actor id"
            requires :followed_id, type: String, desc: "follow id"
          end
          post "/remove" do
            generate_response(::Follow::ActorRemoveFollowService.new(user_id: params[:user_id], followed_id: params[:followed_id]).call)
          end
        end
      end
    end
  end
end
