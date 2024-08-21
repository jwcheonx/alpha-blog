class ChangeAuthorIdNotNull < ActiveRecord::Migration[7.1]
  def change
    change_column_null :articles, :author_id, false
  end
end
