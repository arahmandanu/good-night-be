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

    Result.success(user.as_json)
  end
end
