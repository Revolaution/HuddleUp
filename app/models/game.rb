class Game < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  has_many :participatings
  has_many :participants, through: :participatings
  belongs_to :sport
  belongs_to :location

  validates :max_number_of_participants, :description, :difficulty, :creator, :sport, :start_at, :end_at, :location, :address, :date, presence: true

  validate :date_cannot_be_in_past
  validate :start_time_must_be_before_end_time

  def date_cannot_be_in_past
    errors.add(:date, "cannot be in past") if !date.blank? && date < Date.today
  end

  def start_time_must_be_before_end_time
    errors.add(:end_at, "cannot be before start time") if !end_at.blank? && !start_at.blank? && start_at > end_at
  end

  def current_participants_count
    self.participants.count
  end

  def available_space
    self.max_number_of_participants - self.current_participants_count
  end

  def not_full?
    self.current_participants_count != self.max_number_of_participants
  end

  def valid_teams
    self.creator.teams.select{|team| team.users.any?{|member| !self.participants.include?(member)}}
  end
end
