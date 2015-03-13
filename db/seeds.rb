require_relative '../app/models/list'
require_relative '../app/models/word'
require_relative '../app/controllers/controller'


list = List.create
Controller.grab_info
Controller.grab_info.each do |each_word|
  list.words.create(word: each_word[:word], definition: each_word[:definition], example: each_word[:example])
end
 #Array of hashes
