class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :text
      t.text :background
      t.integer :category_id

      t.timestamps
    end
  end
end
