class SleepsHistories::ActorGetListFollowedService < AbstractService
  def initialize(params)
    @params = params
  end

  attr_reader :params
  def call
    contract_result = SleepsHistories::ActorGetListFollowedContract.new.call(params)

    return Result.failure(contract_result) unless contract_result.success?

    # Only valid data reaches here
    user = Redis::User::Get.new(params[:user_id]).call
    return Result.failure(error_messages_for(user)) unless user.save

    start_date = params[:start_date].present? ? params[:start_date].to_date.beginning_of_day.in_time_zone("UTC") : 7.days.ago.beginning_of_day.in_time_zone("UTC")
    end_date = params[:end_date].present? ? params[:end_date].to_date.end_of_day.in_time_zone("UTC") : Date.current.end_of_day.in_time_zone("UTC")

    # SQL optimized: only following users
    sql = <<~SQL
      SELECT s.*
      FROM sleeps s
      WHERE s.user_id IN (
        SELECT followed_id
        FROM user_follows
        WHERE user_id = :user_id
      )
      AND s.start_time BETWEEN :start_date AND :end_date
      ORDER BY s.duration_seconds DESC
    SQL

    # Paginate manually (since raw SQL bypasses Kaminari)
    page     = (params[:page] || 1).to_i
    per_page = (params[:per_page] || 20).to_i
    offset   = (page - 1) * per_page

    sleeps = Sleep
               .includes(:user) # preload user details
               .find_by_sql([ sql + " LIMIT :limit OFFSET :offset",
                             { user_id: params[:user_id],
                               start_date: start_date,
                               end_date: end_date,
                               limit: per_page,
                               offset: offset } ])

    total_count = Sleep.count_by_sql([ <<~SQL, { user_id: params[:user_id], start_date: start_date, end_date: end_date } ])
      SELECT COUNT(*)
      FROM sleeps s
      WHERE s.user_id IN (
        SELECT followed_id
        FROM user_follows
        WHERE user_id = :user_id
      )
      AND s.start_time BETWEEN :start_date AND :end_date
    SQL

    response = {
      data: sleeps.map do |sleep|
        {
          id: sleep.id,
          start_time: sleep.start_time,
          end_time: sleep.end_time,
          duration_seconds: sleep.duration_seconds,
          user: {
            id: sleep.user.id,
            name: sleep.user.name
          }
        }
      end,
      meta: {
        total_count: total_count,
        current_page: page,
        per_page: per_page,
        total_pages: (total_count.to_f / per_page).ceil
      }
    }

    Result.success(response)
  end
end
