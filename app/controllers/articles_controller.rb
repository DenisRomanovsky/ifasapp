class ArticlesController < ApplicationController

  def index
    @articles = Article.includes(:mechanism_category).all
  end
end
