
class PigLatin
	def self.translate(sentance)
		sentance.split(/\s+/).collect do |word|
			capitalized = (word[0] == word[0].upcase)
			word, punctuation = word.match(/(\w+)(\W*)$/).captures
			word.downcase!
			front, back = word.match(/^(qu|[^aeiou]*)(.*)$/).captures
			word = back + front + 'ay'
			word.capitalize! if capitalized
			word + punctuation
		end.join(" ")
	end
end
