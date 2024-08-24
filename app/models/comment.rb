class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :author, class_name: 'User', inverse_of: :comments

  validates :body, presence: true
end
