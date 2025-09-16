module V1
  class Main < Grape::API
    format :json

    resource :main do
      desc "Returns hello world"
      get do
        { message: "Hello, world!" }
      end
    end

    add_swagger_documentation(
      mount_path: "doc",
      api_version: "v1",
      hide_documentation_path: true,
      info: {
        title: "Good Night API",
        description: "API documentation for Good Night app"
      }
    )
  end
end
