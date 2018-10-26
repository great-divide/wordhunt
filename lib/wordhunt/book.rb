class Wordhunt::Book
	attr_accessor	:title, :info_url, :text_url, :fulltext

	@@all = []

# 	HASH_ARRAY = [
# 	{title: "Me", info_url: "http://www.archive.org", text_url: "http://google.com", fulltext: "aoijoijoijoijo"}, 
# 	{title: "You", info_url: "http://www.archive.org", text_url: "http://google.com", fulltext: "18987987987987124"},
# 	{title: "Everyone", info_url: "http://www.archive.org", text_url: "http://google.com", fulltext: "mn,mn,mnnmnbmnbmnb"}
# ]

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
		# binding.pry
	end

	def self.all
		@@all
	end
end