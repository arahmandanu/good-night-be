class SleepsHistories::ActorGetListFollowedContract < ApplicationContract
  params do
    required(:user_id).filled(:string)
    optional(:start_date).maybe(:date)
    optional(:end_date).maybe(:date)
    optional(:page).maybe(:integer)
    optional(:per_page).maybe(:integer)
  end

  rule(:user_id) do
    uuid_regex = /\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/i
    key.failure("must be a valid UUID") unless value =~ uuid_regex
  end

  rule(:start_date) do
    if value.present?
      key.failure("must be a valid date") unless value.is_a?(Date)
    end
  end

  rule(:end_date) do
    if value.present?
      key.failure("must be a valid date") unless value.is_a?(Date)
    end
  end

  rule(:page, :per_page) do |key|
    if value && value <= 0
      key.failure("must be a positive integer")
    end
  end
end
