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
      redirect_to @wiki
    else
      render 'index'
    end
  end

  def edit
  end

  def wiki_params
    params.require(:wiki).permit(:title, :body)
  end

  
end
