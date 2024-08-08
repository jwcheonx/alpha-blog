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

  has_secure_password

  before_save :downcase_email

  private

  def downcase_email
    # `email'         -- Calls `User#email'.
    # `self.email'    -- Calls `User#email'.
    # `email ='       -- Initializes a local variable.
    # `self.email = ' -- Calls `User#email='.
    self.email = email.downcase
  end
end
