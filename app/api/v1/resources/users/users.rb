module V1
  module Resources
    module Users
      class Users < Grape::API
        format :json

        resource :users do
          desc "Returns user details"
          get "/:id/detail" do
            generate_response(::Users::ActorGetDetailService.new(params[:id]).call)
          end

          desc "Create a user"
          params do
            requires :name, type: String, desc: "User's name"
          end
          post do
            generate_response(::Users::ActorCreateService.new(name: params[:name]).call)
          end
        end
      end
    end
  end
end
