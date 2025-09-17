class Follow::ActorAddFollowContract < ApplicationContract
  params do
    required(:user_id).filled(:string)
    required(:followed_id).filled(:string)
  end

  rule(:user_id).validate(:uuid)
  rule(:followed_id).validate(:uuid)
  rule(:followed_id) do
    if values[:user_id] == values[:followed_id]
      key.failure("You are not allowed to follow yourself")
    end
  end
end
