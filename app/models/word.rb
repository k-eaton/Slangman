class Word < ActiveRecord::Base

  belongs_to :list

  validates :word, :definition, :example, { :presence => true }

  validates :word, format: { with: /.{5,}/ }
  validates :word, format: { without: /[A-Z]{2,}/ }
  # validates :word, format: { without: /\D*\d\D*/ }

  def self.remove_word_from_definition
    Word.all.map do |row|
      blanks = row.word.gsub(/[a-zA-Z]/,"_")
      p blanks
      p row.word
      new_definition = row.definition.gsub!(row.word, blanks)
      p row.definition
      row.update(definition: new_definition)
    end
  end

end

