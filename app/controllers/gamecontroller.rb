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
    puts "Missed letters: #{@missed_letters.join(", ")}"
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
    welcome
    until @missed_letters.length == 6 || solved?
      guess
      puts "Here's a hint: #{@definition}" if @stickman.wrong_guesses >= 2
    end
    puts "Game Over!\nWord/Phrase is: #{@secret_word}" if @missed_letters.length == 6
    win if solved?
    puts "The phrase used in a sentence: #{@example}" if solved?
  end


  def welcome
    puts <<-Welcome
 __        __   _                            _          ____  _                                         _
 \\ \\      / /__| | ___ ___  _ __ ___   ___  | |_ ___   / ___|| | __ _ _ __   __ _ _ __ ___   __ _ _ __ | |
  \\ \\ /\\ / / _ \\ |/ __/ _ \\| '_ ` _ \\ / _ \\ | __/ _ \\  \\___ \\| |/ _` | '_ \\ / _` | '_ ` _ \\ / _` | '_ \\| |
   \\ V  V /  __/ | (_| (_) | | | | | |  __/ | || (_) |  ___) | | (_| | | | | (_| | | | | | | (_| | | | |_|
    \\_/\\_/ \\___|_|\\___\\___/|_| |_| |_|\\___|  \\__\\___/  |____/|_|\\__,_|_| |_|\\__, |_| |_| |_|\\__,_|_| |_(_)
                                                                            |___/
   This is a Hangman game created by: Katarina Eaton, Mike Perez, Joyce De La Torre, and Kevin Ceballos. Words are obtained
   by scraping the UrbanDictionary frontpage for recent "Word of the Day"s. Have fun!
   Let's Begin!

  Welcome
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
    puts  "Mystery Word: #{@board.join(" ")}"
  end

  def solved?
    return true if !(@board.include?("_"))
    false
  end

end


# word = "dat ass doe"
# definition = "\nThat ass though.A woman can be an idiot, or have ..."
# example = "\n\"Dat hoe has got an ugly face, but dat ass doe\"Fr..."

