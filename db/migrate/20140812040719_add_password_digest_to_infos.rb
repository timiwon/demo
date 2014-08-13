class AddPasswordDigestToInfos < ActiveRecord::Migration
  def change
    add_column :infos, :password_digest, :string
  end
end
