class Follow::ActorListFollowedContract < ApplicationContract
  params do
    required(:user_id).filled(:string)
    optional(:page).filled(:integer, gt?: 0)
    optional(:per_page).filled(:integer, gt?: 0, lteq?: 100)
  end

  rule(:user_id).validate(:uuid)
end
