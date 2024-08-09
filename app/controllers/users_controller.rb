class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to articles_path,
                  status: :see_other,
                  notice:
                    "Welcome to the Alpha Blog, #{@user.username}. You've successfully signed up."
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
