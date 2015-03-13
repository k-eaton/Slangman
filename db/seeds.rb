require_relative 'app/models/list'
require_relative 'app/models/word'

list = List.create

list.tasks.create(Controller.grab_info) #Array of hashes
