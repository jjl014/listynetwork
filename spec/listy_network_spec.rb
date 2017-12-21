require 'listy_network'

describe '#dynamicEditDistance' do
  context 'substitution' do
    it 'gives edit distance for one substitution' do
      expect(dynamicEditDistance("LISTY", "LISTS")).to eq(1)
    end

    it 'gives edit distance for multiple substitutions' do
      expect(dynamicEditDistance("RUSTY", "LISTS")).to eq(3)
    end
  end

  context 'deletion' do
    it 'gives edit distance for one deletion' do
      expect(dynamicEditDistance("LISTY", "LISTS")).to eq(1)
    end

    it 'gives edit distance for multiple deletions' do
      expect(dynamicEditDistance("LISTY", "IST")).to eq(2)
    end
  end

  context 'insertion' do
    it 'gives edit distance for one insertion' do
      expect(dynamicEditDistance("LISTY", "LISTS")).to eq(1)
    end

    it 'gives edit distance for multiple insertions' do
      expect(dynamicEditDistance("ER", "BAKERY")).to eq(4)
    end
  end

  context 'mix editing' do
    it 'gives edit distance for multiple edits' do
      expect(dynamicEditDistance("HELLO", "GEL")).to eq(3)
    end
  end
end

describe '#min' do
  context 'when given 3 numbes' do
    it 'returns min for positive numbers' do
      expect(min(1,4,6)).to eq(1)
    end

    it 'returns min for negative numbers' do
      expect(min(-5,4,6)).to eq(-5)
    end
  end
end

describe '#findNetworkCount' do
  it 'finds network size given test dictionary' do
    expect(findNetworkCount("HI", 'test.txt')).to eq(7)
  end

  it 'finds network size given small dictionary' do
    expect(findNetworkCount("LISTY", 'very_small_test_dictionary.txt')).to eq(5)
  end

  # it 'finds network size given quarter dictionary to be 31556' do
  #   expect(findNetworkCount("LISTY", 'quarter_dictionary.txt')).to eq(31556)
  # end

  it 'finds network size given the full dictionary' do
    expect(findNetworkCount("LISTY", 'dictionary.txt')).to eq(5)
  end
end

describe 'TrieNode' do
  let(:trie) { TrieNode.new }

  it 'starts out empty' do
    expect(trie.word).to be_nil
    expect(trie.children.length).to eq(0)
  end

  it 'inserts a word into the trie' do
    trie.insert("PIZZA")
    node = trie
    while node.children.length > 0
      next_letter = node.children.keys[0]
      node = node.children[next_letter]
    end

    expect(trie.children["P"]).to be_truthy
    expect(node.word).to eq("PIZZA")
  end
end

describe '#build_trie' do
  it 'builds a trie with a given dictionary' do
    trie = build_trie('dictionary.txt')
    expect(trie.children.include?("F")).to be_truthy
    expect(trie.children.include?("L")).to be_truthy
  end
end

describe '#search' do
  it 'searches the trie' do
    trie = build_trie('very_small_test_dictionary.txt')
  end
end
