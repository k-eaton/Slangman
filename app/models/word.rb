class Word < ActiveRecord::Base

  belongs_to :list

  validates :word, :definition, :example, { :presence => true }

  validates :word, format: { with: /.{5,}/ }
  validates :word, format: { without: /[A-Z]{2,}/ }
  validates :word, format: { without: /\D*\d\D*/ }

end

