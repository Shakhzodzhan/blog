class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "oops", password: "secret", except: [:index, :show]

  #функция которая передает все артиклы, которые есть
  def index
    @articles = Article.all
  end

  #функция которая передает шоу страницу, что бы ввести туда новый артикль
  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  #метод редактирования, по правилу CRUD - "U" - Update
  def edit
    @article = Article.find(params[:id])
  end


  #функция для ввода арктикла
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end


  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end


  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

private
  def article_params
    params.require(:article).permit(:title, :text)
  end
end
