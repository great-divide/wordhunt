class Wordhunt::Word_search
	attr_accessor :wordbank, :scrape, :fulltexts

	WORD_ARRAY = %w[laconic insipid pragmatic iconoclast arduous profligate prosaic obsequious capricious fortuitous orthodox alacrity pellucid corroborate magnanimous scrupulous prolific dogmatic placate]

	def initialize(word, scrape =nil)
		@wordbank = []
		@scrape = scrape
		@fulltexts = []

		@wordbank << word

		if @scrape == nil
    	  	@scrape = Wordhunt::Scraper.scrape_titles_and_links("https://archive.org/details/gutenberg")
    		@scrape.delete_if { |n| n[:text] == nil }
    		# searches for sentences that include word, stores as sentences attr of word object
    		word.sentences = new_search_for_single_word(@scrape, word.name)
    	else 
    		# since the scrape has already happened, this method searches stored texts rather than re-scraping
    		sentence_array = []
    		@fulltexts.each do |text|
    	  		text.scan /[^.?!]*(?<=[.?\s!])#{input}(?=[\s.?!])[^.?!]*[.?!]/ do |n|
            		sentence_array << n
      			end
    		end
    		word.sentences = sentence_array
    	end

    	self.return_sentences(word)
	end

	def new_search_for_single_word(hash_array, word)
    	final_hash_array = []

    	hash_array.each do |foo|
      		doc = Nokogiri::HTML(open(foo[:text])).text
      		# make it pretty
      		doc.gsub!("\r", " ")
      		doc.gsub!("\n", " ")
      		# doc.gsub!("\\", "")
      		@fulltexts << doc
    	end

    	sentence_array = []
    	@fulltexts.each do |text|
    		text.scan /[^.?!]*(?<=[.?\s!])#{word}(?=[\s.?!])[^.?!]*[.?!]/ do |n|
            	sentence_array << n
      		end
    	end

    	sentence_array
  	end

  	def return_sentences(word_object)
    	word_object.count = word_object.sentences.length
    	puts "We found #{word_object.count} sentence(s) for you to check out: \n"
    	puts word_object.sentences.join("\n")  

    	puts "Would you like to search for another word? Enter y/n"
    	
    	begin
    	response = gets.strip
    	end until response == "y" || response == "n"
    	
    	if response == "y"
    	  self.next_search
    	elsif response == "n"
    	  puts "Ok, have a logophilic day!"
    	end	
  	end

  	# repeats word search, but searches stored texts rather than re-scraping
  	def next_search
    	puts WORD_ARRAY
    
    	begin 
    	puts "Which word do you want to search for now?"
    	input = gets.strip
    	end until WORD_ARRAY.include?(input)

    	puts "This will just take a second. Do a couple of vocab flashcards!"
    	new_word = Wordhunt::Word_object.new(input)

    	sentence_array = []
    	@fulltexts.each do |text|
      		text.scan /[^.?!]*(?<=[.?\s!])#{input}(?=[\s.?!])[^.?!]*[.?!]/ do |n|
            	sentence_array << n
      		end
    	end

    	new_word.sentences = sentence_array

    	self.return_sentences(new_word)
  	end
# class end
end