class Users::ActorCreateService
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
    user = User.create!(contract_result.to_h)
    Result.success(user)
  end
end
