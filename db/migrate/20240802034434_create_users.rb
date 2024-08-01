class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username, null: false, collation: 'NOCASE'
      t.string :email, null: false, collation: 'NOCASE'

      t.timestamps
    end

    add_index :users, :username, unique: true, name: 'ux_users_username'
    add_index :users, :email, unique: true, name: 'ux_users_email'
  end
end
