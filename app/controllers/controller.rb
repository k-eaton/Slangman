require 'nokogiri'
require 'open-uri'
class Controller
  def initialize
    # (arg)
    # @model = arg.fetch(:model) #Word
    # @collection = arg.fetch(:collection).first #List
    # @view = arg.fetch(:view).new
    # @nokogiri_doc = Nokogiri::HTML(open("http://www.urbandictionary.com"))
  end

  def self.grab_info
    noko = Nokogiri::HTML(open("http://www.urbandictionary.com"))
    words = noko.search('.def-header > a:first-child').map{|word| word.inner_text}
    definitions = noko.search('.meaning').map{|definition| definition.inner_text}
    examples = noko.search('.example').map{|example| example.inner_text}
    info_array = words.zip(definitions,examples)
    info_array.each_with_object(arr_of_hs = []) do |array|
        h = {}
        h[:word] = array[0]
        h[:definition] = array[1]
        h[:example] = array[2]
        arr_of_hs << h
    end
    arr_of_hs
  end
end


# class Word
#   def initialize(args)
#     @word = args.fetch(:word)
#     @definition = args.fetch(:definition)
#     @example = args.fetch(:example)
#   end
# end

# controller = Controller.new
