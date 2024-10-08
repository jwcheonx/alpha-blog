class ArticlesController < ApplicationController
  include Pagy::Backend

  before_action :require_login, only: %i[new edit create update destroy restore list_trashed]
  before_action :set_article, only: %i[show edit update destroy restore]
  before_action :authorize, only: %i[edit update destroy restore]

  def index
    @pagy, @articles = pagy(
      Article.preload(:author, :categories)
             .kept
             .published
             .order(published_at: :desc)
    )
  end

  def show
    if @article.discarded? || !@article.published?
      require_login and return
      authorize and return
    end

    @pagy, @comments = pagy(@article.comments.preload(:author))
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
    @article.discard || @article.destroy!

    flash.notice = 'Article moved to trash' if @article.persisted?
    redirect_to current_user, status: :see_other
  end

  def restore
    @article.undiscard!
    redirect_to current_user, notice: 'Article restored'
  end

  def list_trashed
    articles = current_user.articles
                           .preload(:author, :categories)
                           .discarded
                           .order(discarded_at: :desc)

    @pagy, @articles = pagy(
      current_user.admin? ? articles.unscope(where: :author_id) : articles
    )
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, :published_at, category_ids: [])
  end

  def authorize
    return if @article.author_id == current_user.id || current_user.admin?

    redirect_back_or_to root_path, alert: 'Unauthorized'
  end
end
