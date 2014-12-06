# class for the DATABASE
class DB4Search
 
  def initialize
    @data_base = []
  end

# creates a data base with the  words in the document filtered by length and singular appearance
  def create(filename, word_input_1)
  	@@start_word = word_input_1
	File.open(filename) { |file| file.each_line { |line| @data_base << line.chomp.downcase } }
	# Delete every element of @data_base for which word.length != @start_word.length .
	@data_base = @data_base.keep_if { |word| word.length == @@start_word.length }
	# if there are two or more equal words in @data_base , they are deleted
	@data_base = @data_base.uniq
	@data_base
  end

# searches the @data_base , compares each word and creates another db chained_words_db with words with 
# a max 1 letter difference
  def search_the_db(by_word,db) 
    @chained_words_db = []
    db.each do |word_in_db|
      count_dif = 0
 	  # iterates over each letter of the word and counts the different letters
  	  word_in_db.length.times { |i| count_dif += 1 if word_in_db[i] != by_word[i] }
  	  @chained_words_db << word_in_db if count_dif == 1
      end
    @chained_words_db
  end

end

# class for the CHAINS
class Searcher < DB4Search

  def initialize
    @stack = []
  end

  def breadth_first_lambda(word_input_2,db)	
  	# uses a @stack of lambdas to follow 
    @stack << lambda {|db| {:used_words => [@@start_word], :next_words => search_the_db(@@start_word, db) } }

    while !@stack.empty?
      # calls the lambda in index 0 of the @stack in the variable check	
  	  check = @stack.shift.call(db)
  	  
  	  # checks if in the @chained_words_db generated with search_the_db(@@start_word) includes the word_input_2  	  
  	  if check[:next_words].include?(word_input_2)
  	  	# if the stop word is found in the @chained_words_db,that means we found the chain 
        puts "#{(check[:used_words] + [word_input_2]).join(" or ")} ?"
        # we delete the @stack because we want to breack the while
        @stack.clear 
      else
      	# if we don't find the stop word in the @chained_words_db we move to the other next words in row 
        check[:next_words].each do |next_word|
          # adds the next word in line in the @chained_words_db to the used words until now
        used_words = check[:used_words] + [next_word]
          # adds in the @stack a lambda to store the used words and move forward with the search in the @data_base 
        @stack << lambda {|db| {:used_words => used_words, :next_words => search_the_db(next_word, db) } }
          # deletes from db the words encountered until now
        db -= check[:used_words] + check[:next_words]
          # now we go back to shift the @stack and check again
        end

      end
    end
  end

end

3.times { puts }
puts "**** You are using Bogdan's handwrite recognition software ****"
puts "Please handwrite on the screen : "
print "> "
word_input_1 = gets.chomp
#word_input_2 = [*('a'..'z')].sample(word_input_1.length).join
#print "Did you mean to write : "
#puts word_input_2
puts "I can't read what you wrote to me. Please handwrite again on the screen : "
print "> "
word_input_2 = gets.chomp
puts "Did you want to write : "

store = DB4Search.new
data_base = store.create("words.txt", word_input_1)

chain = Searcher.new
chain.breadth_first_lambda(word_input_2,data_base)

3.times { puts }
