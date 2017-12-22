# listynetwork

## Running the tests
In the root directory, run:

`bundle install`

`bundle exec rpsec spec`

## Challenge Overview
* Count the size of the social network of the word LISTY using the provided dictionary file
* Use Levenshtein's distance to calculate the edit distance between two words

## Notes
Using the bottom up implementation of Levenshtein's distance, I was able to get the network size of LISTY on the smaller dictionary files. However, when testing it against any of the larger dictionary files, it would run for a long long time. I think the bottleneck might be in the implementation of findNetworkCount where we keep computing the Levenshtein distance for each pair of words even though we might have already computed it before.

Using the Trie implementation of Levenshtein's distance was much more efficient since we won't need to rebuild a whole table for every word we check. A set was also used to keep track of the words we have already visited. We then continuously search for friends, friends of friends, etc.. and increment a counter to keep track of the network size.

Here are some run times with different dictionaries:

very small test dictionary: 5
run time: ~0.0006s

quarter dictionary: 31556
run time: ~50s

half dictionary: 69347
run time: ~2min 30s

full dictionary: 176243
run time: ~9min
