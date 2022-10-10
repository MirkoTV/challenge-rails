class Profile < ApplicationRecord
  validates :username, uniqueness: true
  validates_format_of :username, :with => /\A[a-zA-Z0-9\-]+\Z/

  has_many :repositories
end
