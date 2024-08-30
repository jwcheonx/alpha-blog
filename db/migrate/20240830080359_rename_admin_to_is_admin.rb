class RenameAdminToIsAdmin < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :admin, :is_admin
  end
end
