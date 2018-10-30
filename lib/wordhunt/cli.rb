require 'pry'

class Wordhunt::CLI

	WORD_ARRAY = %w[laconic insipid pragmatic iconoclast arduous profligate prosaic obsequious capricious fortuitous orthodox alacrity pellucid corroborate magnanimous scrupulous prolific dogmatic placate]

    def call
        puts "Oh my! You're early. Give me a moment to prepare..."

        # scrape things, make books
        Wordhunt::Scraper.scrape_titles_and_links("https://archive.org/details/gutenberg") 

        start
    end

	def start
		puts WORD_ARRAY 
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

        begin
        puts "Do you want to search for another word? (enter y/n)"
        response = gets.strip.downcase
        end until response == "y" || response == "n"

        if response == "y"
          puts WORD_ARRAY
          puts "Which word do you want to search for now?"
          menu
        elsif response == "n"
          puts "Ok, have a logophilic day!"
        end  
    end

    def search(input)

        Wordhunt::Word.new(input) if !Wordhunt::Word.find_by_name(input)

        word = Wordhunt::Word.find_by_name(input)

       if word.sentences == []
            Wordhunt::Book.all.each do |book|
                book.fulltext.scan /[^.?!]*(?<=[.?\s!])#{input}(?=[\s.?!])[^.?!]*[.?!]/ do |n|
                    word.sentences << n
                end
            end
        end
    end

  
    def print_sentences(word)

        puts "We found #{word.sentences.length} sentence(s) for you to check out: \n"
        word.sentences.each.with_index(1) do |s, index|
            puts " "
            puts "#{index}. #{s.strip}"
        end
        puts " "
    end
end
