class SecretCode < ApplicationRecord
  belongs_to :user, optional: true
  validates :code_string, uniqueness: true
  scope :available_code, -> { where(user_id: nil) }
  scope :unavailable_code, -> { where.not(user_id: nil) }
end
