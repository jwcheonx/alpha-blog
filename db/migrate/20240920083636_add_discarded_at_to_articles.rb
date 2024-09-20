class AddDiscardedAtToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :discarded_at, :datetime
    add_index :articles, :discarded_at, name: 'ix_articles_discarded_at'
  end
end
