class Users::ActorCreateService < AbstractService
  def initialize(params)
    @params = params
  end

  attr_reader :params
  def call
    # Validate input using ApplicationContract
    contract_result = Users::ActorCreateContract.new.call(params)

    unless contract_result.success?
      # Return structured errors
      return Result.failure(contract_result)
    end

    # Only valid data reaches here
    user = User.new(contract_result.to_h)
    return Result.failure(error_messages_for(user)) unless user.save

    Redis::User::Set.new(user).call
    Result.success(user.as_json)
  end
end
