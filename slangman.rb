require_relative 'config/application'

controller = Controller.New ({
  :model => Task,
  :collection => List,
  :view => View,
  :command => ARGV[0] ? ARGV[0] : nil,
  :task_data => ARGV[1...-1] ? ARGV[1] : nil
  })
