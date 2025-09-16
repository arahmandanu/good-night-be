module V1
  class Main < Grape::API
  format :json

  mount V1::Resources::Users::Users
  mount V1::Resources::Follows::User

  add_swagger_documentation(
    mount_path: "doc",
    api_version: "v1",
    hide_documentation_path: true,
    info: {
      title: "Good Night API",
      description: "API documentation for Good Night app",
      contact_email: "adrian.rahmandanu2@gmail.com"
    }
  )
  end
end
