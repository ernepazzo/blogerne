class ArticlesController < ApplicationController
    # before_action :find_acticle, only: [:show,:edit,:update,:destroy]
    before_action :find_acticle, except: [:new,:create,:index,:from_author]
    before_action :authenticate_user!, only: [:new,:create,:edit,:update,:destroy,:from_author]

    def index
        @articles = Article.all
    end
    
    def show
    end

    def edit
        @categories = Category.all
    end

    def update
        @article.update(article_params)
        @article.save_category
        redirect_to @article
    end
    
    def new
        @article = Article.new
        @categories = Category.all
    end

    def create
        @article = current_user.articles.create(article_params)
        
        @article.save_category

        redirect_to @article
    end

    def destroy
        @article.destroy
        redirect_to root_path
    end

    def from_author
        @user = User.find(params[:user_id])
    end

    def find_acticle
        @article = Article.find(params[:id])
    end

    def article_params
        puts params
        params.require(:article).permit(:title,:content,category_elements: [])
    end
end
