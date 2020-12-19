require 'ipaddr'

class Like < ApplicationRecord
  validates :ip_address, presence: true
  validates_uniqueness_of :message_id, scope: :ip_address
  validate :validate_ip_format

  belongs_to :message

  def validate_ip_format
    IPAddr.new(self.ip_address)
  rescue => err
    self.errors.add(:ip_address, :invalid, message: err.message)
  end
end