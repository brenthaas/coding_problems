# Word Chains:
# Two words are connected by a word chain if it is possible 
#  to change one into the other by making a series of single-character 
#  changes, such that every intermediate form is also a word. For example, 
#  CAT and DOG are connected with a word chain because CAT, COT, COG and 
#  DOG are all words. 'DEMONIC' and 'UMBRELLA' are not (but I do love my 
#  demonic umbrellas).
#
# Write a program that takes a list of words (for example 
#  /usr/share/dict/words on a unix system) and then reads pairs of words 
#  on stdin and prints 'YES' if the words are connected by a chain, and 
#  'NO' if they are not. The program should take the path to the word list 
#  as a command-line argument, and should then loop, reading pairs of 
#  whitespace-delimited words on stdin and printing 'YES' or 'NO.'
#
# Only one operation is allowed between words in the chain. That operation 
#  may consist of changing any single character, deleting any single character 
#  or inserting any single character at any position. All comparisons should be 
#  case insensitive.

class String
	def chains_to?(other_word)
		#short-circut cases where there's more than 1 character difference
		if (length_diff = (other_word.length-self.length).abs) <= 1
			this = self.split(//)
			that = other_word.split(//)
			diffs = []
			this.each_index do |index|
				diffs.push(this[index]) if this[index] != that[index]
			end	
			true if (diffs.size + length_diff) < 2
		end
	end
end

if __FILE__ == $PROGRAM_NAME
	begin
		word_list = File.new(ARGV[0], "r")
		words = {}
		word_list.each { |word| words[word.chomp!.downcase] = true }
		puts "Please enter word pairs:"
		$stdin.each_line do |response|
			response.chomp!
			exit if response =~ /^q(:?uit)?$/i 		# listen for q[uit]
			if response =~ /^(\w*)\s+(\w*)$/
				first = $1.downcase
				second = $2.downcase
				if words[first] && words[second] && first.chains_to?(second)
					puts "YES"
				else
					puts "NO"
				end
			else
				puts "Please enter two words separated by whitespace:"
			end
		end
	rescue
		puts "Error opening file #{ARGV[0]}"
	end
end