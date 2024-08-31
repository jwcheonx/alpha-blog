class UsersController < ApplicationController
  include Pagy::Backend

  before_action :require_login, only: %i[edit update]
  before_action :set_user, only: %i[show edit update destroy]
  before_action :authorize, only: %i[edit update destroy]

  def index
    @pagy, @users = pagy(User.all)
  end

  def show
    articles = @user.articles.preload(:categories)

    @pagy, @articles = pagy(
      if logged_in? && (@user == current_user || current_user.admin?)
        articles
      else
        articles.published
      end
    )
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
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

  def destroy
    @user.destroy!

    # Administrator who deletes other user's account will remain logged in.
    session[:user_id] = nil if @user == current_user
    redirect_to root_path, notice: 'Account deleted'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def authorize
    return if @user == current_user || (current_user.admin? && action_name == 'destroy')

    redirect_to @user, alert: "Cannot edit or delete other users' profiles"
  end
end
