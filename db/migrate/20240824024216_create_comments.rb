class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.references :article,
                   null: false,
                   foreign_key: { on_delete: :cascade },
                   index: false
      t.references :author,
                   null: false,
                   foreign_key: { to_table: 'users', on_delete: :cascade },
                   index: false

      t.timestamps
    end

    add_index :comments, :article_id, name: 'fx_comments_article_id'
    add_index :comments, :author_id, name: 'fx_comments_author_id'
  end
end
