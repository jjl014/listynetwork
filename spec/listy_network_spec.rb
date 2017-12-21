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

  it 'finds network size given quarter dictionary' do
    expect(findNetworkCount("LISTY", 'quarter_dictionary.txt')).to eq(5)
  end
end
