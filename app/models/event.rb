class Event < ApplicationRecord
  has_many :users

  validates :start_dt, :start_dt_after_now, presence: true

  private

  def start_dt_after_now
    start_dt > Time.now
  end
end

