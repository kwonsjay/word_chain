class WordChains
  #Set accessors
  attr_accessor :dictionary, :start_word, :end_word, :flag
  
  #Initialize WordChains with starting and ending words, as well as dictionary
  #Limit dictionary to include only cleaned words of the same length as inputs
  def initialize(start_word, end_word, dictionary_path = "dictionary.txt")
    @start_word = start_word
    @end_word = end_word
    @dictionary = File.readlines(dictionary_path).map do |word|
      word.chomp
    end.select { |word| word && word.length == start_word.length }
    @visited_words = {}
    @skip_indices = []
  end
  
  #Reduce the dictionary further if start and end word both contain a character
  #in the same locations
  def dict_reduce
    common_letters = [].tap do |letters_array|
      @start_word.split("").each_with_index do |char, index|
        letters_array << [char, index] if char == @end_word[index]
        @skip_indices << index
      end
    end
    common_letters.each do |char, location|
      @dictionary.select! { |word| word[location] == char }
    end
  end
  
  #Given a word, find all adjacent unique words that are in the dictionary
  def adjacent_words(word)
    new_words_array = []
    word.split("").each_with_index do |char, index|
      next if @skip_indices.include?(index)
      ("a".."z").each do |delta|
        new_word = word.dup
        new_word[index] = delta unless delta == char
        if @dictionary.include?(new_word) && !@visited_words.include?(new_word)
          new_words_array << new_word
          @visited_words[new_word] = word
        end
      end
    end
    new_words_array
  end
  
  def find_path
    
  end
  
end