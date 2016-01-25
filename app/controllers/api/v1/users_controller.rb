class Api::V1::UsersController < ApplicationController
  include AuthMixin

  skip_before_filter :authenticate, only: :create
  
  def create
    user = User.new(user_params)
    if user.save
      return render status: 201, json: generate_auth_data(user) 
    end
    render json: {errors: user.errors.full_messages}, status: 422
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
