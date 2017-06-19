class Profile < ActiveRecord::Base
	belongs_to :user
	has_attached_file :picture,styles: { medium: "500x500>", thumb: "180x180>" }, default_url: "/images/:style/missing.png"
	validates_attachment :picture,
                     content_type: { content_type: ["image/jpeg", "image/gif", "image/png", "image/jpg"] }
    # validates :first_name,:phone_no,:gender,:dob,:address,:occupation, presence: true
end
