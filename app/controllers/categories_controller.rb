class CategoriesController < ApplicationController
  include Pagy::Backend

  before_action :require_login, :authorize, only: %i[new edit create update]
  before_action :set_category, only: %i[show edit update]

  def index
    @pagy, @categories = pagy(Category.all)
  end

  def show
    @pagy, @articles = pagy(
      @category.articles
               .preload(:author, :categories)
               .published
               .order(published_at: :desc)
    )
  end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category, notice: 'Category created'
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @category.update(category_params)
      redirect_to @category, notice: 'Category updated'
    else
      render :edit, status: :unprocessable_content
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
