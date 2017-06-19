class Picture < ActiveRecord::Base
  belongs_to :listing
  has_attached_file :file, styles: { medium: "800x800>", thumb: "180x180>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/
end
