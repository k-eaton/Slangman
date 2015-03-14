require_relative 'controller'
require_relative '../../config/application'
class Stickfigure
  attr_reader :wrong_guesses
  def initialize()
    @body = <<-FORMAT


     |--------|
     |
     |
     |
     |
     =============

    FORMAT
    @wrong_guesses = 0
  end

  def incr_wrong_guesses
    @wrong_guesses += 1
  end
  def display_hangman
    case
    when @wrong_guesses == 1
      @body =  <<-FORMAT


     |--------|
     |        O
     |
     |
     |
     =============

    FORMAT
    when @wrong_guesses == 2
    @body =  <<-FORMAT


     |--------|
     |        O
     |        |
     |
     |
     =============

    FORMAT
    when @wrong_guesses == 3
    @body =  <<-FORMAT


     |--------|
     |        O
     |       /|
     |
     |
     =============

    FORMAT
    when @wrong_guesses == 4
    @body =  <<-FORMAT


     |--------|
     |        O
     |       /|\\
     |
     |
     =============

    FORMAT
    when @wrong_guesses == 5
    @body =  <<-FORMAT


     |--------|
     |        O
     |       /|\\
     |       /
     |
     =============

    FORMAT
   when @wrong_guesses == 6
    @body =  <<-FORMAT


     |--------|
     |        O
     |       /|\\
     |       / \\
     |
     =============

    FORMAT
  end
  print @body
 end
end


class Hangman
  def initialize(secret_word_object)
    @secret_word = secret_word_object.word
    @definition = secret_word_object.definition
    @example = secret_word_object.example
    @board = []
    @missed_letters = []
    @secret_word.length.times{@board << "_"}
    @stickman = Stickfigure.new
  end

  def guess
    replace_board(@secret_word, @board, " ")
    puts "Guess a letter:"
    letter = gets.chomp

    if letter.length > 1
      puts "Invalid input, guess again"
      guess

    elsif @board.include?(letter) || @missed_letters.include?(letter)
      puts "Guess Again. You already guessed that.."
      guess
    elsif @secret_word.split("").include?(letter)
      puts "Good Guess!"
      # @board[@secret_word.index(letter)] = letter
      #replace all elements in board with letter. Input: [c,_,_,l] & "o" Output: [c,o,o,l]
      replace_board(@secret_word, @board, letter)
    else
      @missed_letters << letter
      @stickman.incr_wrong_guesses
    end
    @stickman.display_hangman
    display_board
    puts "Missed letters: #{@missed_letters}"
  end

  def replace_board(word, board, letter)
  #replace all elements in board with letter. Input: "cool", [c,_,_,l] & "o" Output: [c,o,o,l]
  word_arr = word.split("")
  (0..board.length).each do |num|
    if word_arr[num] == letter
      board[num] = letter
    end
  end
  end

  def play_game
    until @missed_letters.length == 6 || solved?
      guess
      puts "Hint: #{@definition}" if @stickman.wrong_guesses >= 2
    end
    puts "Game Over!\nWord is: #{@secret_word}" if @missed_letters.length == 6
    win if solved?
    puts "Use: #{@example}" if solved?
  end

  def win
    puts <<-win
  ____    ____  ______    __    __     ____    __    ____  __  .__   __.  __
  \\   \\  /   / /  __  \\  |  |  |  |    \\   \\  /  \\  /   / |  | |  \\ |  | |  |
   \\   \\/   / |  |  |  | |  |  |  |     \\   \\/    \\/   /  |  | |   \\|  | |  |
    \\_    _/  |  |  |  | |  |  |  |      \\            /   |  | |  . `  | |  |
      |  |    |  `--'  | |  `--'  |       \\    /\\    /    |  | |  |\\   | |__|
      |__|     \\______/   \\______/         \\__/  \\__/     |__| |__| \\__| (__)

    win
  end

  def display_board
    puts  "Mystery Word: #{@board}"
  end

  def solved?
    return true if !(@board.include?("_"))
    false
  end

end

class Word
  attr_reader :word, :definition, :example
  def initialize(args)
    @word = args[:word]
    @definition = args[:definition]
    @example = args[:example]
  end
end

# word = "dat ass doe"
# definition = "\nThat ass though.A woman can be an idiot, or have ..."
# example = "\n\"Dat hoe has got an ugly face, but dat ass doe\"Fr..."
sampled_word = Word.all.sample
word = Word.new(sampled_word)
test_game = Hangman.new(word)
test_game.play_game
