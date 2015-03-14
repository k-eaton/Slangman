require_relative 'config/application'
require_relative 'app/models/list'
require_relative 'app/models/word'
require_relative 'app/controllers/controller'
require_relative 'app/controllers/gamecontroller'
require_relative 'app/views/view'


controller = Controller.new(
  :model => Word,
  :collection => List,
  :view => View,
  )


sampled_word = Word.all.sample
word = Word.new(sampled_word)
test_game = Hangman.new(word)
test_game.play_game
