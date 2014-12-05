# my steps for solving the problem :

# 1. read each word in the file 

# 2. determin the length of each word and for each length value I create an array containing the words of that value length

# 3. I create a hash : key are the length of the words ; values are the array of words with each key value length

# 4. I determin the length of my given words 

# 5. I select the array (value from hash ) associated to the key word.length

# 6. from this array I create an unoriented graph (nodes are the words, edges are the relation between 2 nodes who have 
# one letter difference in structure	)

# 7. apply breadth first to find the shortest path from word 1 to word 2


# Now, for the actual implementation in Ruby I'll probably need a little bit more time ..... 