class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:credentials][:email].downcase)
    if user&.authenticate(params[:credentials][:password])
      redirect_to user, notice: 'Logged in'
    else
      flash.now.alert = 'Invalid email or password'
      render :new, status: :unauthorized
    end
  end
end
