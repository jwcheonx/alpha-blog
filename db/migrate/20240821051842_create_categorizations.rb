class CreateCategorizations < ActiveRecord::Migration[7.1]
  def change
    create_table :categorizations do |t|
      t.references :article,
                   null: false,
                   foreign_key: { on_delete: :cascade },
                   index: false
      t.references :category,
                   null: false,
                   foreign_key: { on_delete: :cascade },
                   index: false

      t.timestamps
    end

    add_index :categorizations,
              %i[article_id category_id],
              unique: true,
              name: 'ux_categorizations_article_id_category_id'
    add_index :categorizations,
              %i[category_id article_id],
              unique: true,
              name: 'ux_categorizations_category_id_article_id'
  end
end
