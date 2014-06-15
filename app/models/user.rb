class User < ActiveRecord::Base

  has_many :questions
  has_many :answers
  has_many :identities

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :twitter]

  def self.find_for_oauth(auth)
    identity = Identity.where(auth.slice(:provider, :uid)).first
    return identity.user if identity

    email = auth.info ? auth.info.email : "tmp_#{auth.uid}_#{auth.provider}@localdomain.com"
    user = User.where(email: email).first_or_create! do |user|
      user.email = email
      user.password = Devise.friendly_token[0,20]
    end

    user.identities.create!( auth.slice(:provider, :uid) )
    user
  end

end
