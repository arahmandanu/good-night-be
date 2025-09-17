class Follow::ActorRemoveFollowContract < ApplicationContract
  params do
    required(:id).filled(:string)
    required(:followed_id).filled(:string)
  end

  rule(:id).validate(:uuid)
  rule(:followed_id).validate(:uuid)
end
