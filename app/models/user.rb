class User < ApplicationRecord
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
