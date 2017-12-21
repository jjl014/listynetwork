require 'byebug'

def dynamicEditDistance(str1, str2)
  matrix = Array.new(str1.length + 1) { Array.new(str2.length + 1) }

  # Set up first row of matrix
  (0...matrix[0].length).each do |i|
    matrix[0][i] = i
  end

  # Set up first column of matrix
  (0...matrix.length).each do |i|
    matrix[i][0] = i
  end

  # Build the matrix
  (1..str1.length).each do |i|
    (1..str2.length).each do |j|
      # If the current letters are the same, we take the old value
      # since there is no edit distance. Otherwise, we take the minimum
      # of the three values of substituion, deletion, or insertion
      if str1[i-1] == str2[j-1]
        matrix[i][j] = matrix[i-1][j-1]
      else
        matrix[i][j] = 1 + min(matrix[i-1][j-1], matrix[i-1][j], matrix[i][j-1])
      end
    end
  end

  return matrix[str1.length][str2.length]
end

def min(num1, num2, num3)
  smallest = num1 < num2 ? num1 : num2
  return smallest < num3 ? smallest : num3
end

def findNetworkCount(target_word, dictionary_file)
  words = File.readlines(dictionary_file).map(&:chomp)

  # Create a word hash to keep track of words already seen
  word_hash = {}
  words.each do |word|
    word_hash[word] = true
  end

  # Start the queue with our target_word
  queue = [target_word]

  # Keep a counter for the network size
  count = 0

  while !queue.empty?
    current_word = queue.shift()
    # Mark current word seen as false and increment the network count
    if word_hash[current_word]
      word_hash[current_word] = false
      count += 1
    else
      # Skip it since we've seen the word already
      next
    end

    # Iterate through the word hash and look only at the words
    # that hasn't been seen yet
    word_hash.each do |k, v|
      next unless v
      # Make sure that the word hasn't been seen yet then check
      # the Levenshtein edit distance. If it's 1, push the word into
      # the queue and continue checking
      if word_hash[k] && (dynamicEditDistance(current_word, k) == 1)
        queue.push(k)
      end
    end
  end

  return count
end
