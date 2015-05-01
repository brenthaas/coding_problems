class Trie

  def initialize(words)
    words.each{ |word| add_word(word) }
    @root_node = Node.new
  end

  def add_word(word)
    node = @root_node
    word_size = word.length
    word.each_with_index do |char, index|
      next_node = node.child_node(char)
      if next_node
        node = next_node
      else
        new_node = Node.new('char')
        node.add_child(new_node)
        node = new_node
      end
      node.is_word! if index+1 == word_size
    end
  end
end


class Node
  attr_reader :letter, :is_word, :child_nodes

  def initialize(letter)
    @letter = letter
    child_nodes
  end

  def child_node(char)
    child_nodes[char]
  end
end
