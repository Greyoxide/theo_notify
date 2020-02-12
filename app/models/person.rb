class Person < ApplicationRecord
  has_many :assignments

  extend FriendlyId
  friendly_id :full_name, use: :slugged

  def full_name
    "#{first_name} #{last_name}".titleize
  end
end
