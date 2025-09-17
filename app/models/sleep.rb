class Sleep < ApplicationRecord
  belongs_to :user

  validates :start_time, presence: true
  validates :end_time, presence: true, if: -> { duration_seconds.present? }
  validates :duration_seconds, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validate :end_time_after_start_time, if: -> { start_time.present? && end_time.present? }
  validates :user_id, uniqueness: { scope: :end_time, message: "can have only one open sleep session" }, if: -> { end_time.nil? }
  # validate :duration_minimum, if: -> { duration_seconds.present? }

  scope :open, -> { where(end_time: nil) }
  scope :close, -> { where.not(end_time: nil) }

  before_save :calculate_duration, if: :end_time_changed?
  after_create :increment_clockin_cache

  private

  def increment_clockin_cache
    Redis::Sleeps::UserClockin.new(user.id).increment
  end

  def duration_minimum
    if duration_seconds < 15*60
      errors.add(:duration_seconds, "must be at least 15 minutes")
    end
  end

  def calculate_duration
    return if start_time.nil? || end_time.nil?

    self.duration_seconds = (end_time - start_time).to_i
  end

  def end_time_changed?
    will_save_change_to_end_time?
  end

  def end_time_after_start_time
    if end_time <= start_time
      errors.add(:end_time, "must be after start time")
    end
  end
end
