class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: 3..25
end
