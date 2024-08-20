require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest
  setup do
    @admin = User.create!(
      username: 'johndoe', email: 'jdoe@example.org', password: 'password', admin: true
    )
    log_in_as @admin
  end

  test 'should create new category by submitting form' do
    get new_category_path
    assert_response :success

    post categories_path, params: { category: { name: 'Sports' } }
    assert_response :redirect
    follow_redirect!

    assert_response :success
    assert_select 'h1', 'Category: Sports'
  end

  test 'should reject creation of invalid category' do
    get new_category_path
    assert_response :success

    assert_no_difference(-> { Category.count }) do
      post categories_path, params: { category: { name: ' ' } }
    end

    assert_select 'h2', /Could not save the category/
  end
end
