class Article < ApplicationRecord
  validates :title, presence: true, length: 6..100
  validates :description, presence: true, length: 10..300
end
