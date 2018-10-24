class Wordhunt::CLI

	WORD_ARRAY = %w[laconic insipid pragmatic iconoclast arduous profligate prosaic obsequious capricious fortuitous orthodox alacrity pellucid corroborate magnanimous scrupulous prolific dogmatic placate]

	def start
		puts WORD_ARRAY
    	begin 
    	puts "Here are some vocabulary words that commonly appear on the GRE. Choose one and we'll find instances of its use in classic literature."
    	input = gets.strip 
    	end until WORD_ARRAY.include?(input)

    	puts "This might take a few minutes. Go read a New Yorker article and come back."

    	word = Wordhunt::Word_object.new(input)

    	Wordhunt::Word_search.new(word)
	end
end