class Users::ActorCreateContract < ApplicationContract
  params do
    required(:name).filled(:string)
  end
end
