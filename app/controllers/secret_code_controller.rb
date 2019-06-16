class SecretCodeController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :authenticate_admin


  def new
    @secret_code = SecretCode.new
  end

  def index
    @secret_code = SecretCode.new
    @unavailable_secret_codes = SecretCode.unavailable_code
  end

  def generate_rand_num
    range = [*'0'..'9',*'A'..'Z',*'a'..'z']
    Array.new(8){ range.sample }.join
  end

  def create
    if params.present? && params[:code_count].present?
      input_code_count = params[:code_count].to_i
      input_code_count.times do |a|
        SecretCode.create(code_string: generate_rand_num)
      end
      flash[:notice] = "secret code created successfully."
      redirect_to root_path
    end
  end

  private

  def authenticate_admin
    unless current_user.admin?
      flash[:notice] = "Invalid User."
      redirect_to root_path
    end 
  end

  def secret_code_params
    params.permit(:secret_code, keys: [:code_string])
  end
end
