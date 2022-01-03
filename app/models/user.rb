class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :playlists, dependent: :destroy
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[spotify]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
