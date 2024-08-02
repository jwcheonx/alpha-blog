class Article < ApplicationRecord
  belongs_to :author, class_name: 'User', inverse_of: :articles

  validates :title, presence: true, length: 6..100
  validates :description, presence: true, length: 10..300
end
