class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attr_accessor :secret_code
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :secret_code, dependent: :destroy
  belongs_to :role
  validates :first_name, :last_name, presence: true 
  before_validation :check_secret_code
  after_commit :set_secret_code

  def admin?
    role.try(:name) == "admin" ? true : false 
  end

  private

  def set_secret_code
    secret_code = SecretCode.find_by(id: self.secret_code)
    if secret_code.present?
      secret_code.user_id = self.id 
      secret_code.save!
    end 
  end

  def check_secret_code
    if self.secret_code.blank?
      errors.add(:secret_code, "can't be blank")
    elsif SecretCode.available_code.find_by(code_string: self.secret_code).blank?
      errors.add(:secret_code, "Is invalid, please enter valid secret code.")
    end
  end
end
