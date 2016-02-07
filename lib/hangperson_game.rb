class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word.downcase
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess(letter)
    raise ArgumentError.new unless (letter and (letter != '') and (letter.match(/^[[:alpha:]]+$/)))
    letter.downcase!
    if @word[letter] and !@guesses[letter]
        @guesses << letter
    else
      if !@wrong_guesses[letter] and !@guesses[letter]
        @wrong_guesses << letter
      else
        false
      end
    end
    
  end
  
  def word_with_guesses
    guessy = ''
    word.split("").each do |i|
      if @guesses[i]
        guessy << i
      else
        guessy << '-'
      end
    end
    return guessy
  end
  
  def check_win_or_lose
    check_state = word_with_guesses
    if !check_state['-']
      return :win
    elsif @wrong_guesses.length >= 7
      return :lose
    else
      return :play
    end
  end
  
end
