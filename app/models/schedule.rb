class Schedule < ApplicationRecord
  belongs_to :user
  has_many :comments through :schedule, dependent: :destroy
end
