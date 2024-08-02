class User < ApplicationRecord
  has_many :articles, inverse_of: :author, dependent: :destroy

  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: 3..25
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { maximum: 105 },
            format: URI::MailTo::EMAIL_REGEXP
end
