class Message < ApplicationRecord
  validates :author, presence: true, length: {maximum: 50}
  validates :message, presence: true, length: {maximum: 5000}
  validates :likes, presence: true
end