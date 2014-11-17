class CreateCachedPercentageResults < ActiveRecord::Migration
  def change
    create_table :cached_percentage_results do |t|
      t.integer :user1_id
      t.integer :user2_id
      t.float :score1
      t.float :score2
      t.float :final_score

      t.timestamps
    end

    add_index :cached_percentage_results, :user1_id
    add_index :cached_percentage_results, :user2_id
    add_index :cached_percentage_results, :final_score
  end
end
