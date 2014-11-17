class AddSectionToUser < ActiveRecord::Migration
  def up
    add_column :users, :section, :string
    add_index  :users, :section

    User.update_all(:section => "J")
  end

  def down
    remove_index  :users, :section
    remove_column :users, :section
  end
end
