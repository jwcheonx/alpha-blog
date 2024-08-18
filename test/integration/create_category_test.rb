require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest
  test 'should create new category by submitting form' do
    get new_category_path
    assert_response :success

    post categories_path, params: { category: { name: 'Sports' } }
    assert_response :redirect
    follow_redirect!

    assert_response :success
    assert_select 'h1', 'Category: Sports'
  end
end
