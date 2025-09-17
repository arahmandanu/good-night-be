class Follow::ActorListFollowedService < AbstractService
  def initialize(params: nil)
    @params = params
  end

  def call
    # Validate input using ApplicationContract
    contract_result = Follow::ActorListFollowedContract.new.call(user_id: @params[:user_id], page: @params[:page], per_page: @params[:per_page])

    unless contract_result.success?
      return Result.failure(contract_result)
    end

    user =  Redis::User::Get.new(contract_result[:user_id]).call
    return Result.failure("User not found") unless user

    followed_users = user.followed_users.page(contract_result[:page]).per(contract_result[:per_page])
    Result.success(build_paginate_response(followed_users))
  end
end
