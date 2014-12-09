class WikisController < ApplicationController

  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    if @wiki.save
      notice = "created!"
      redirect_to @wiki
    else
      notice = "error creating"
      render 'index'
    end
  end

  def edit

    @wiki = Wiki.find(params[:id])
    
  end

  def update

    @wiki = Wiki.find(params[:id])
    if @wiki.update_attributes(params.require(:wiki).permit(:title, :body))
      notice = "Updated!"
      redirect_to @wiki
    else
      alert = "error saving the post"
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      notice = "destroyed!"
      redirect_to wikis_path
    else
      notice = "error deleting"
      render :show
    end

  end

  def wiki_params
    params.require(:wiki).permit(:title, :body)
  end
  
end
