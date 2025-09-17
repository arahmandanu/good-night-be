module V1
  class Main < Grape::API
    helpers V1::Helpers

    mount V1::Resources::Users::Users
    mount V1::Resources::Follows::User
    mount V1::Resources::Sleeps::Sleeps

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
