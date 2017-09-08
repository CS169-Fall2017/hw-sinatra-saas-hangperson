class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :word, :guesses, :wrong_guesses
  # def initialize()
  # end
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(input)
    raise ArgumentError if input.nil? || input.empty? || (input =~ /[^A-Za-z]/)

    input.downcase!             #https://stackoverflow.com/questions/1020568/how-to-convert-a-string-to-lower-or-upper-case-in-ruby
    if (@guesses.include? input) || (@wrong_guesses.include? input)
       false
    else
      if (@word.include? input)
        @guesses << input         #https://stackoverflow.com/questions/2356905/appending-to-an-existing-string
      else
        @wrong_guesses << input
      end
    end
  end
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
