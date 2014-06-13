class User < ActiveRecord::Base

  has_many :questions
  has_many :answers
  has_many :identities

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  def self.find_for_facebook_oauth(auth)
    identity = Identity.where(auth.slice(:provider, :uid)).first
    return identity.user if identity

    user = User.where(email: auth.info.email).first_or_create! do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
    user.identities.create!( auth.slice(:provider, :uid) )
    user
  end

end
