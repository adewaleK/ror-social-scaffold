class Friendship < ApplicationRecord
  belongs_to :sent_to, class_name: 'User', foreign_key: 'sent_to_id'
  belongs_to :sent_by, class_name: 'User', foreign_key: 'sent_by_id'
  validates :sent_by, presence: true
  validates :sent_to, presence: true
  scope :friends, -> { where('status =?', true) }
  scope :not_friends, -> { where('status =?', false) }
end
