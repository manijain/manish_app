class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @available_secret_codes = SecretCode.available_code
    @secret_code = SecretCode.new
  end
end
