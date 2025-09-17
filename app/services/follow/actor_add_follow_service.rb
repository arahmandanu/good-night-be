class Follow::ActorAddFollowService < AbstractService
  def initialize(user_id: nil, followed_id: nil)
    @user_id = user_id
    @followed_id = followed_id
  end

  def call
    # Validate input using ApplicationContract
    contract_result = Follow::ActorAddFollowContract.new.call(user_id: @user_id, followed_id: @followed_id)

    unless contract_result.success?
      return Result.failure(contract_result)
    end

    user =  Redis::User::Get.new(@user_id).call
    return Result.failure("User not found") unless user

    followed_user =  Redis::User::Get.new(@followed_id).call
    return Result.failure("User not found") unless user

    follow_relation = user.user_follows.build(followed: followed_user)
    return Result.failure(error_messages_for(follow_relation)) unless follow_relation.save

    Result.success("Successfully followed user")
  end
end
