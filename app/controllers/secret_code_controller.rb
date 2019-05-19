class SecretCodeController < ApplicationController
  before_action :authenticate_admin

  def index
    @secret_code = SecretCode.all
  end

  def new
    @secret_code = SecretCode.new
  end

  def generate_rand_num
    range = [*'0'..'9',*'A'..'Z',*'a'..'z']
    Array.new(8){ range.sample }.join
  end

  def create
    if params.present? && params[:code_strig].present?
      input_code_count = params[:code_strig].to_i
      input_code_count.times do |a|
        SecretCode.create(code_strig: generate_rand_num)
      end
      flash[:notice] = "secret code created successfully."
      redirect_to secret_code_index_path
    else
      render: :new 
    end
  end

  private

  def authenticate_admin
    current_user.role.try(:name).eql?("admin")
  end

  def secret_code_params
    params.permit(:secret_code, keys: [:code_string])
  end
end
