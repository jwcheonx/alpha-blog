require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest
  setup do
    @c1, @c2 = Category.create!([{ name: 'Sports' }, { name: 'Travel' }])
  end

  test 'should list category links' do
    get categories_path

    assert_select 'a[href=?]', category_path(@c1), { text: @c1.name }
    assert_select 'a[href=?]', category_path(@c2), { text: @c2.name }
  end
end
