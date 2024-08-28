class Article < ApplicationRecord
  belongs_to :author, class_name: 'User', inverse_of: :articles

  has_many :comments, -> { order(created_at: :desc) }, inverse_of: :article, dependent: :destroy

  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations

  validates :title, presence: true, length: 6..100
  validates :description, presence: true, length: 10..300
end
