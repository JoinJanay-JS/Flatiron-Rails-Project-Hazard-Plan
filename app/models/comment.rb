class Comment < ApplicationRecord
  belongs_to :schedule
  belongs_to :user
end
