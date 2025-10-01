class Mentor < ApplicationRecord
  has_many :submissions

  def full_name
    "#{first_name} #{last_name}"
  end
end
