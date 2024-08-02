class AddAuthorIdToArticles < ActiveRecord::Migration[7.1]
  def change
    add_reference :articles,
                  :author,
                  foreign_key: { to_table: :users, on_delete: :cascade },
                  index: false

    add_index :articles, :author_id, name: 'fx_articles_author_id'
  end
end
