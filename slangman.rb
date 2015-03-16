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


 Controller.grab_info.each do |each_word|
    List.first.words << Word.create(word: each_word[:word], definition: each_word[:definition], example: each_word[:example])
  end

sampled_word = Word.all.sample
sampled_word.update(word: sampled_word.word.downcase)
test_game = Hangman.new(sampled_word)
test_game.play_game
