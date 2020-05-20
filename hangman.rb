class Hangman
  DICTIONARY = ["cat", "car","cut", "cap", "dog", "bootcamp", "pizza",'became', 'arrow', 'article', 'therefore','beside', 'between','army', 'beautiful', 'became', 'if', 'actually']
  
  attr_reader :guess_word, :attempted_chars, :remaining_incorrect_guesses

  def self.random_word
    DICTIONARY.sample 
  end

  def initialize
    @secret_word=Hangman.random_word
    @guess_word=Array.new(@secret_word.size,"_")
    @attempted_chars=[]
    @remaining_incorrect_guesses=@secret_word.size*3
  end
  
  def already_attempted?(c)
    @attempted_chars.include?c
  end

  def get_matching_indices(c)
    arr=@secret_word.split("").each_index.select {|i|  @secret_word.split("")[i]==c}
    arr
  end

  def fill_indices(c,ar)
    ar.each{|v| @guess_word[v]=c}
  end

  def try_guess(c)
    if already_attempted?(c)
      print 'that has already been attempted'
      return false
    end
      @attempted_chars << c
    
      arr=self.get_matching_indices(c)
      self.fill_indices(c,arr)

      @remaining_incorrect_guesses-=1 if arr.empty?
    true 
  end

  def ask_user_for_guess
    print 'Enter a char:'
    guess=gets.chomp
    self.try_guess(guess)
  end

  def win?
    if  @guess_word.join("")==@secret_word
      print 'WIN'
      return true
    end
    false
  end

  def lose?
    if @remaining_incorrect_guesses==0
      print 'LOSE'
      return true
    end
    false
  end

  def game_over?
    if self.win? || self.lose?
      print @secret_word
      return true
    end
    false
  end

end
