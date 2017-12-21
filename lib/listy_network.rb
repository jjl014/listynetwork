require 'byebug'

class TrieNode
  attr_accessor :word, :children

  def initialize
    @word = nil
    @children = {}
  end

  def insert(word)
    node = self
    word.each_char do |ch|
      node.children[ch] = TrieNode.new unless node.children[ch]
      node = node.children[ch]
    end
    node.word = word
  end
end

def build_trie(dictionary)
  trie = TrieNode.new
  File.readlines(dictionary).each do |word|
    trie.insert(word.chomp)
  end
  trie
end

def search(trie, word, maxCost)
  current_row = (0..word.length).to_a
  results = []

  trie.children.each_key do |key|
    search_trie(trie.children[key], key, word, current_row, results, maxCost)
  end
  return results
end

def search_trie(node, letter, word, previous_row, results, maxCost)
  columns = word.length
  current_row = [previous_row[0] + 1]
  1.upto(columns).each do |col|
    insertCost = current_row[col - 1] + 1
    deleteCost =  previous_row[col] + 1
    subCost = previous_row[col - 1]

    subCost += 1 unless word[col - 1] == letter

    current_row << [insertCost, deleteCost, subCost].min
  end

  if current_row.last <= maxCost && !node.word.nil?
    results << node.word
  end

  if current_row.min <= maxCost
    node.children.each_key do |key|
      search_trie(node.children[key], key, word, current_row, results, maxCost)
    end
  end
end

def min(num1, num2, num3)
  smallest = num1 < num2 ? num1 : num2
  return smallest < num3 ? smallest : num3
end

def findNetworkCount(target_word, dictionary_file)
  trie = build_trie(dictionary_file)
  queue = [target_word]

  count = 0

  set = Set.new

  while !queue.empty?
    count += 1
    current_word = queue.shift()
    unless (set.include?(current_word))
      set.add(current_word)
      res = search(trie, current_word, 1)
      res.each do |word|
        queue << word unless set.include?(word)
      end
    end
  end
  return count
end

# def dynamicEditDistance(str1, str2)
#   matrix = Array.new(str1.length + 1) { Array.new(str2.length + 1) }
#
#   # Set up first row of matrix
#   (0...matrix[0].length).each do |i|
#     matrix[0][i] = i
#   end
#
#   # Set up first column of matrix
#   (0...matrix.length).each do |i|
#     matrix[i][0] = i
#   end
#
#   # Build the matrix
#   (1..str1.length).each do |i|
#     (1..str2.length).each do |j|
#       # If the current letters are the same, we take the old value
#       # since there is no edit distance. Otherwise, we take the minimum
#       # of the three values of substituion, deletion, or insertion
#       if str1[i-1] == str2[j-1]
#         matrix[i][j] = matrix[i-1][j-1]
#       else
#         matrix[i][j] = 1 + min(matrix[i-1][j-1], matrix[i-1][j], matrix[i][j-1])
#       end
#     end
#   end
#
#   return matrix[str1.length][str2.length]
# end

# def findNetworkCount(target_word, dictionary_file)
#   words = File.readlines(dictionary_file).map(&:chomp)
#
#   # Create a word hash to keep track of words already visited
#   word_hash = {}
#   words.each do |word|
#     word_hash[word] = false
#   end
#
#   # Start the queue with our target_word
#   queue = [target_word]
#   set = Set.new([target_word])
#
#   # Keep a counter for the network size
#   count = 1
#
#   while !queue.empty?
#     current_word = queue.shift()
#     # Iterate through the word hash and look only at the words
#     # that hasn't been visited yet
#     p current_word
#     word_hash.each do |key, val|
#       # Make sure that the word hasn't been visited yet, if it has
#       # then skip. Then check the Levenshtein edit distance. If it's 1,
#       # push the word into the queue and continue checking
#       if !val && dynamicEditDistance(current_word, key) == 1
#         queue.push(key)
#         word_hash[current_word] = true
#         count += 1
#       end
#     end
#   end
#
#   return count
# end
