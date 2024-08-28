class AddArticlesCountToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :articles_count, :integer,
               null: false, default: 0

    up_only do
      User.find_each do |u|
        User.reset_counters(u.id, :articles)
      end
    end
  end
end
