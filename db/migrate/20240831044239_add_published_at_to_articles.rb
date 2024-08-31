class AddPublishedAtToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :published_at, :datetime

    up_only do
      Article.find_each do |a|
        a.update!(published_at: a.created_at)
      end
    end
  end
end
