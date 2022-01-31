class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]

  #   def index
  #     @relevant_articles = Article.get_by_state("Relevant")
  #     @expired_articles = Article.get_by_state("Expired")
  #     @closed_articles = Article.get_by_state("Closed")
  # end

    def show
    end

    def index
      @articles = Article.paginate(page: params[:page], per_page: 5)
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
      @article.user = current_user
      if @article.save
        flash[:notice] = "Advertisement was created successfully."
        redirect_to @article
      else
        render 'new'
      end
    end

    def change_state
      @article = Article.find(params[:article_id])
      @article.update(state: params[:state].to_i)
      redirect_to @article
    end

  def article_by_state(state)
      self.articles.select do |article|
          article.state == state
      end
  end
  
    private

    def set_article
      @article = Article.find(params[:id]) 
    end

    def article_params
      params.require(:article).permit(:title, :description, :expiration_date)
    end

    def require_same_user
      if current_user != @article.user && !current_user.admin?
        flash[:alert] = "Only the owner of a ad can edit or delete a ad"
        redirect_to @article
      end
    end

end