class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  devise :omniauthable, omniauth_providers: [:google_oauth2]

        has_many :schedules, dependent: :destroy
        has_many :comments, through: :schedules, dependent: :destroy
       
        accepts_nested_attributes_for :schedules

        validates :username, presence: true, uniqueness: true

end
