class User < ApplicationRecord
  validates_presence_of :name, :email

  before_create :set_token_and_subscription

  private

  def set_token_and_subscription
    self.token = SecureRandom.hex
    self.subscribed = true
  end
end
