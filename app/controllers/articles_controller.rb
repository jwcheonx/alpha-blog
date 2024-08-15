class ArticlesController < ApplicationController
  include Pagy::Backend

  before_action :require_login, only: %i[new edit create update destroy]
  before_action :set_article, only: %i[show edit update]

  def index
    @pagy, @articles = pagy(Article.all)
  end

  def show; end

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
    Article.destroy!(params[:id])
    redirect_to articles_path, status: :see_other, notice: 'Article deleted'
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
