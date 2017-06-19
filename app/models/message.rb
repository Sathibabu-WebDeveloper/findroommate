class Message < ActiveRecord::Base
	belongs_to :user
  belongs_to :admin
	belongs_to :listing
	validates :name,:message,:phoneno, presence: true

	def self.search(search)
    if search
      self.where("id like ?", "%#{search}%")
    else
      self.all
    end
  end

end
