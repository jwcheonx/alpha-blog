class UsersController < ApplicationController
  include Pagy::Backend

  before_action :set_user, only: %i[show edit update]

  def index
    @pagy, @users = pagy(User.all)
  end

  def show
    @pagy, @articles = pagy(@user.articles)
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user,
                  notice:
                    "Welcome to the Alpha Blog, #{@user.username}. You've successfully signed up."
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Account information updated'
    else
      render :edit, status: :unprocessable_content
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
