require 'pry'

class Wordhunt::CLI

	WORD_ARRAY = %w[laconic insipid pragmatic iconoclast arduous profligate prosaic obsequious capricious fortuitous orthodox alacrity pellucid corroborate magnanimous scrupulous prolific dogmatic placate]

    def call
        puts "Oh my! You're early. Give me a moment to prepare..."

        # SCRAPE THINGS (make books?) 
        Wordhunt::Scraper.scrape_titles_and_links("https://archive.org/details/gutenberg") 

        start
    end

	def start
		puts WORD_ARRAY
    	# begin 
    	puts "Here are some vocabulary words that commonly appear on the GRE. Choose one and we'll find instances of its use in classic literature."
    
    	menu
	end

    def menu
        input = gets.strip 

        while !WORD_ARRAY.include?(input)
            puts "Choose a word from the list (watch your spelling!)"
            input = gets.strip
        end

        puts "This will just take a second. Do a couple of vocab flashcards!" 

        search(input) 

        print_sentences(Wordhunt::Word.find_by_name(input))

        puts "Do you want to search for another word?"

        begin
        response = gets.strip
        end until response == "y" || response == "n" || response == "Y" || response == "N"
        
        if response == "y" || response == "Y"
          puts WORD_ARRAY
          puts "Which word do you want to search for now?"
          menu
        elsif response == "n" || response == "N"
          puts "Ok, have a logophilic day!"
        end  
    end

    def search(input)

        Wordhunt::Word.new(input) if !Wordhunt::Word.find_by_name(input)

        word = Wordhunt::Word.find_by_name(input)
        # binding.pry
            # since the scrape has already happened, this method searches stored texts rather than re-scraping
       if word.sentences == []
            Wordhunt::Book.all.each do |book|
    
                book.fulltext.scan /[^.?!]*(?<=[.?\s!])#{input}(?=[\s.?!])[^.?!]*[.?!]/ do |n|
                    word.sentences << n
                end
            end
        end
    end

  
    def print_sentences(word)

        word.count = word.sentences.length
        puts "We found #{word.count} sentence(s) for you to check out: \n"
        #  iterate here... puts sentence, puts space, puts sentence...
        word.sentences.each do |s|
            puts " "
            puts "#{s}"
        end
        puts " "
    end
end
