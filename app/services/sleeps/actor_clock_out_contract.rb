class Sleeps::ActorClockOutContract < ApplicationContract
  params do
    required(:user_id).filled(:string)
    required(:sleep_id).filled(:string)
  end

  rule(:user_id).validate(:uuid)
  rule(:sleep_id).validate(:uuid)
end
