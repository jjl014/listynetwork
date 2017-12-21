# listynetwork

## Running the tests

`bundle install`
`bundle exec rpsec spec`

## Challenge Overview
* Count the size of the social network of the word LISTY using the provided dictionary file
* Use Levenshtein's distance to calculate the edit distance between two words

## Notes
Using the Levenshtein's distance, I was able to get the network size of LISTY on the smaller dictionary files. However, when testing it against any of the larger dictionary files, it would run for a long long time. I think the bottleneck might be in the implementation of findNetworkCount where we keep computing the Levenshtein distance for each pair of words even though we might have already computed it before.

I tried to use an adjacency list as well as an adjacency matrix, but I couldn't wrap my head around how I could use them to help optimize the run time. I settled on using a hash to keep track of which words has been visited while using a BFS implementation to find all the friends that had a edit distance of 1. And it will keep running until it has looked through all the friends, friends of friends, etc..
