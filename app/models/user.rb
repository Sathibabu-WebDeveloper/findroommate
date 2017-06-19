class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and 
  has_many :user_provider, :dependent => :destroy
  has_one :profile, :dependent => :destroy
  has_many :listings , :dependent => :destroy
  has_many :messages
  has_many :subscriptions
  devise :database_authenticatable, :registerable,:omniauthable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauth_providers => [:facebook,  :google_oauth2]
   ratyrate_rater
   acts_as_voter
   # validates :password, :password_confirmation, presence: true    

  def self.search(search)
    if search
      self.where("email like ?", "%#{search}%")
    else
      self.all
    end
  end
end
