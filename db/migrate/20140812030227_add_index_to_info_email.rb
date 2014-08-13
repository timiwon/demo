class AddIndexToInfoEmail < ActiveRecord::Migration
  def change
  	add_index :infos, :email, unique: true
  end
end
