class Api::V1::SessionsController < ApplicationController
  include AuthMixin
  
  skip_before_filter :authenticate, only: :create
  
  def create
    return failure unless params[:user].present?
    email = params[:user][:email]
    user = User.find_by_email(email)
    return failure unless user 

    if user.authenticate(params[:user][:password])
      return render status: 201, json: generate_auth_data(user) 
    end
    failure
  end

  def destroy
    invalidate_current_token
    render json: {}
  end

  private

  def failure
    render json: { errors: ['invalid login'] }, status: 401
  end

end
