class User < ApplicationRecord
  has_many :events, foreign_key: :user_id, class_name: 'Event'
  has_many :attendances, foreign_key: :attendee_id
  has_many :attended_events, through: :attendances, class_name: 'Event'

  validates :name, length: { minimum: 3, maximum: 16 }
  validates :name, presence: true, uniqueness: true
end
