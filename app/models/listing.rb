class Listing < ActiveRecord::Base
	require 'roo'
	has_and_belongs_to_many :rules
	has_and_belongs_to_many :amenities
	validates :title,:description,:room_type,:bedrooms,:rent,:rooms_for_rent,:available_from,:minimumstay,:current_roommates,:prefred_gender,:prefred_age,:prefred_occupation, :landmark, :security_deposit,:furnishing_status, presence: true
	has_many :pictures, :dependent => :destroy
	has_many :messages, :dependent => :destroy
	belongs_to :admin
	belongs_to :user
	belongs_to :city
	belongs_to :area
	acts_as_votable
	ratyrate_rateable "features"

	def self.import(file)
	  spreadsheet = open_spreadsheet(file)
	  header = spreadsheet.row(1)
	  (2..spreadsheet.last_row).each do |i|
	    row = Hash[[header, spreadsheet.row(i)].transpose]
	    listing = find_by_id(row["id"]) || new
	    listing.attributes = row.to_hash.slice(*row.to_hash.keys)
	    listing.save!
	  end
	end

	def self.open_spreadsheet(file)
	  case File.extname(file.original_filename)
	  when '.csv' then Roo::Csv.new(file.path,options={})
	   when '.xls' then Roo::Excel.new(file.path,options={})
	   when '.xlsx' then Roo::Excelx.new(file.path,options={})
	   else raise "Unknown file type: #{file.original_filename}"
	  end
	end

end
