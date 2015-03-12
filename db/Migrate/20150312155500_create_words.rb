
class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.integer :list_id
      t.string  :word
      t.text    :definition
      t.text    :example

      t.timestamps
    end
  end
end
