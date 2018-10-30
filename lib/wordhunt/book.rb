class Wordhunt::Book
	attr_accessor	:title, :info_url, :text_url, :fulltext

	@@all = []

	def initialize(hash)

		hash.each { |k, v| 
			self.send("#{k}=", v)
		}
		
		@@all << self
	end

	def self.make_books(hash_array)
		hash_array.each do |book|
			Wordhunt::Book.new(book)
		end
	end

	def self.all
		@@all
	end
end