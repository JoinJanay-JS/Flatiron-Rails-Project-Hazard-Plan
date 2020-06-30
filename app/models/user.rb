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

        def self.from_omniauth(auth)
              user = where(provider: auth.provider, uid: auth.uid).first_or_create do |new_user|
                new_user.provider = auth.provider
                new_user.uid = auth.uid
                new_user.username = auth.info.nickname
              end
       end 
end
