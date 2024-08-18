require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  setup do
    @category = Category.new(name: 'Sports')
  end

  test 'should be valid' do
    assert @category.valid?
  end

  test 'name should be present' do
    @category.name = ' '
    assert_not @category.valid?
  end

  test 'name should be unique' do
    @category.save
    assert_not @category.dup.valid?
  end
end
