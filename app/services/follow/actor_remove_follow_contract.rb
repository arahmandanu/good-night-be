class Follow::ActorRemoveFollowContract < ApplicationContract
  params do
    required(:user_id).filled(:string)
    required(:followed_id).filled(:string)
  end

  rule(:user_id).validate(:uuid)
  rule(:followed_id).validate(:uuid)
end
