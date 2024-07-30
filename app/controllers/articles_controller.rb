class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: 'Article created'
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article, notice: 'Article updated'
    else
      render :edit, status: :unprocessable_content
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
