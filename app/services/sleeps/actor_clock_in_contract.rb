class Sleeps::ActorClockInContract < ApplicationContract
  params do
    required(:user_id).filled(:string)
  end

  rule(:user_id).validate(:uuid)
end
