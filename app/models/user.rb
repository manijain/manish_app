class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :secret_code, dependent: :destroy
  has_one :role
  validates :first_name, :last_name, :secret_code, presence: true 
  attr_accessor :secret_code
  after_create :set_secret_code

  private

  def set_secret_code
    secret_code = SecretCode.available_code.find_by(code_string: secret_code)
    if secret_code.present?
      secret_code.user_id = self.id 
      secret_code.save!
    end 
  end
end
