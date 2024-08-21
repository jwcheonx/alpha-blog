class Category < ApplicationRecord
  has_many :categorizations, dependent: :destroy
  has_many :articles, through: :categorizations

  validates :name, presence: true, uniqueness: true, length: 3..25
end
