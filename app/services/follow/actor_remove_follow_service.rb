class Follow::ActorRemoveFollowService < AbstractService
  def initialize(user_id: nil, followed_id: nil)
    @user_id = user_id
    @followed_id = followed_id
  end

  def call
    contract_result = Follow::ActorRemoveFollowContract.new.call(user_id: @user_id, followed_id: @followed_id)

    return Result.failure(contract_result) unless contract_result.success?

    follow_record = UserFollow.find_by(user_id: @user_id, followed_id: @followed_id)
    return Result.failure("Follow record not found") unless follow_record
    return Result.failure(error_messages_for(follow_record)) unless follow_record.destroy

    Result.success("Successfully unfollow user")
  end
end
