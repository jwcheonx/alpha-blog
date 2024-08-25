class AddArticlesCountToCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :articles_count, :integer,
               null: false, default: 0

    up_only do
      Category.find_each do |c|
        Category.reset_counters(c.id, :articles)
      end
    end
  end
end
