class Wordhunt::Book
	attr_accessor	:title, :info_url, :text_url, :fulltext

	@@all = []

	def initialize(title, info_url, text_url, fulltext)
		@title = title
		@info_url = info_url
		@text_url = text_url
		@fulltext = fulltext
		@@all << self
	end

	def self.make_books(hash_array)
		hash_array.each do |book|
			Wordhunt::Book.new(book[:title], book[:info_url], book[:text_url], book[:fulltext])
		end
	end

	def self.all
		@@all
	end
end