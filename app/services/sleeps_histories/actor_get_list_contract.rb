class SleepsHistories::ActorGetListContract < ApplicationContract
  params do
    required(:user_id).filled(:string)
    optional(:start_date).maybe(:string)
    optional(:end_date).maybe(:string)
    optional(:page).maybe(:integer)
    optional(:per_page).maybe(:integer)
  end

  rule(:user_id) do
    uuid_regex = /\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/i
    key.failure("must be a valid UUID") unless value =~ uuid_regex
  end

  rule(:start_date, :end_date) do |key|
    if value && !(value =~ /\A\d{4}-\d{2}-\d{2}\z/)
      key.failure("must be in 'YYYY-MM-DD' format")
    end
  end

  rule(:page, :per_page) do |key|
    if value && value <= 0
      key.failure("must be a positive integer")
    end
  end
end
