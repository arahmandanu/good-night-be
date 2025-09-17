class Follow::ActorRemoveFollowService < AbstractService
  def initialize(id: nil, user_id: nil)
    @id = id
    @user_id = user_id
  end

  def call
    # Validate input using ApplicationContract
    contract_result = Follow::ActorRemoveFollowContract.new.call(id: @id, user_id: @user_id)

    return Result.failure(contract_result) unless contract_result.success?

    follow_record = UserFollow.find_by(id: @id, user_id: @user_id)
    return Result.failure("Follow record not found") unless follow_record
    return Result.failure(error_messages_for(follow_record)) unless follow_record.destroy

    Result.success("Successfully unfollow user")
  end
end
