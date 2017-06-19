class Area < ActiveRecord::Base
	belongs_to :city
	has_many :rooms, through: :city
	validates :name,:pincode,:city_id, presence: true


	def self.import(file)
	  spreadsheet = open_spreadsheet(file)
	  header = spreadsheet.row(1)
	  (2..spreadsheet.last_row).each do |i|
	    row = Hash[[header, spreadsheet.row(i)].transpose]
	    area = find_by_id(row["id"]) || new
	    area.attributes = row.to_hash.slice(*row.to_hash.keys)
	    area.save!
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
