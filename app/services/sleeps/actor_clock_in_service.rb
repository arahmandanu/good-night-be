class Sleeps::ActorClockInService < AbstractService
  def initialize(user_id)
    @user_id = user_id
  end

  attr_reader :user_id
  def call
    contract_result = Sleeps::ActorClockInContract.new.call(user_id: user_id)

    return Result.failure(contract_result) unless contract_result.success?

    user = Redis::User::Get.new(user_id).call
    return Result.failure("User not found") unless user

    user_sleep = user.sleeps.build(start_time: Time.current)
    return Result.failure(error_messages_for(user_sleep)) unless user_sleep.save

    Result.success(user_sleep.as_json)
  end
end
