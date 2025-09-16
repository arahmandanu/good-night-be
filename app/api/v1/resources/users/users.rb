module V1
  module Resources
    module Users
      class Users < Grape::API   # <-- must inherit from Grape::API
        format :json

        resource :users do
          desc "Returns hello world"
          get do
            { message: "Hello, world!" }
          end

          desc "Create a user"
          params do
            requires :name, type: String, desc: "User's name"
          end
          post do
            result = Usecases::User::ActorCreate.new({ name: params[:name] }).call
            byebug
          end
        end
      end
    end
  end
end
