require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create!(name: 'Sports')
    @admin = User.create!(
      username: 'johndoe', email: 'jdoe@example.org', password: 'password', admin: true
    )
  end

  test 'should get index' do
    get categories_path
    assert_response :success
  end

  test 'should show category' do
    get category_path(@category)
    assert_response :success
  end

  test 'should get new' do
    log_in_as @admin

    get new_category_path
    assert_response :success
  end

  test 'should create category' do
    log_in_as @admin

    assert_difference(-> { Category.count }, 1) do
      post categories_path, params: { category: { name: 'Travel' } }
    end

    assert_redirected_to category_path(Category.last)
  end

  test 'should not create category if not logged in' do
    assert_no_difference(-> { Category.count }) do
      post categories_path, params: { category: { name: 'Travel' } }
    end

    assert_redirected_to login_path
  end

  test 'should not create category if not admin' do
    log_in_as User.create!(username: 'marymoe', email: 'mmoe@example.org', password: 'password')

    assert_no_difference(-> { Category.count }) do
      post categories_path, params: { category: { name: 'Travel' } }
    end

    assert_redirected_to categories_path
  end
end
