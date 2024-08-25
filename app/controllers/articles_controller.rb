class ArticlesController < ApplicationController
  include Pagy::Backend

  before_action :require_login, only: %i[new edit create update destroy]
  before_action :set_article, only: %i[show edit update destroy]
  before_action :authorize, only: %i[edit update destroy]

  def index
    @pagy, @articles = pagy(Article.preload(:author, :categories))
  end

  def show
    @pagy, @comments = pagy(@article.comments.order(created_at: :desc))
  end

  def new
    @article = Article.new
  end

  def edit; end

  def create
    @article = Article.new(article_params) do |a|
      a.author_id = current_user.id
    end

    if @article.save
      redirect_to @article, notice: 'Article created'
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article updated'
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @article.destroy!
    redirect_to current_user, status: :see_other, notice: 'Article deleted'
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  def authorize
    return if @article.author_id == current_user.id || current_user.admin?

    redirect_to @article, alert: "Cannot edit or delete other users' articles"
  end
end
