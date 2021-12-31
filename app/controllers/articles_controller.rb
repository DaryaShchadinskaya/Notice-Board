class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update]
   
    def show
    end

    def index
      @articles = Article.relevant
    end
    
    def new
      @article = Article.new 
    end

    def edit        
    end

    def update
      if @article.update(article_params)  
        flash[:notice] = "Advertisement was updated successfully."
        redirect_to @article
      else
        render 'edit'
      end
    end

    def create
      @article = Article.new(article_params)       
      if @article.save
        flash[:notice] = "Advertisement was created successfully."
        redirect_to @article
      else
        render 'new'
      end
    end

    def change_state
      @article = Articles.find(params[:id])
      @article.update(state: params[:state])
      redirect_to @article
    end

  
    private

    def set_article
      @article = Article.find(params[:id]) 
    end

    def article_params
      params.require(:article).permit(:title, :description, :expiration_date)
    end

end