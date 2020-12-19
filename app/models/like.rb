class Like < ApplicationRecord
  validates :ip_address, presence: true, length: {maximum: 15}
  validates_uniqueness_of :message_id, scope: :ip_address
  belongs_to :message
end