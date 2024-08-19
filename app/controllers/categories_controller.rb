class CategoriesController < ApplicationController
  include Pagy::Backend

  before_action :require_login, :authorize, only: %i[new create]
  before_action :set_category, only: :show

  def index
    @pagy, @categories = pagy(Category.all)
  end

  def show; end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category, notice: 'Category created'
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def authorize
    return if current_user.admin?

    redirect_to categories_path, alert: 'Administrator account required'
  end
end
