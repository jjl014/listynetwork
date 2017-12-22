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

Using the Trie implementation of Levenshtein's distance was much more efficient since we won't need to rebuild a whole table for every word. 
