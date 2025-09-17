class Users::ActorGetDetailService < AbstractService
  def initialize(id)
    @id = id
  end

  attr_reader :id
  def call
    # Validate input using ApplicationContract
    contract_result = Users::ActorGetDetailContract.new.call(id: id)

    unless contract_result.success?
      return Result.failure(contract_result)
    end

    user =  Redis::User::Get.new(id).call
    return Result.failure("User not found") unless user

    Result.success(build_user_response(user))
  end

  private

  def build_user_response(user)
    {
      id: user.id,
      name: user.name,
      created_at: user.created_at,
      updated_at: user.updated_at,
      extra: {
        total_followed: Redis::User::FollowCache.get_followed_count(user),
        total_clock_in: Redis::Sleeps::UserClockIn.new(user.id).total
      }
    }
  rescue
    {}
  end
end
