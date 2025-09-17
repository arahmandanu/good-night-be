class SleepsHistories::ActorGetListService < AbstractService
  def initialize(params)
    @params = params
  end

  attr_reader :params
  def call
    contract_result = SleepsHistories::ActorGetListContract.new.call(params)

    return Result.failure(contract_result) unless contract_result.success?

    # Only valid data reaches here
    user = Redis::User::Get.new(params[:user_id]).call
    return Result.failure(error_messages_for(user)) unless user.save

    start_date = params[:start_date] || 7.days.ago.to_date
    end_date = params[:end_date] || Date.current

    my_histories = Sleep
                      .where(user_id: params[:user_id], start_time: start_date.beginning_of_day..end_date.end_of_day)
                      .order(start_time: :desc)
                      .page(params[:page])
                      .per(params[:per_page])

    Result.success(build_paginate_response(my_histories))
  end
end
