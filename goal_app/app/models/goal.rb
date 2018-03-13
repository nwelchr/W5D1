class Goal < ApplicationRecord
  validates :user, :description, presence: true

  belongs_to :user
  has_many :comments

end
