class WikisController < ApplicationController

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user_id = current_user.id
    authorize @wiki
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
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
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
    authorize @wiki
    if @wiki.destroy
      notice = "destroyed!"
      redirect_to wikis_path
    else
      notice = "error deleting"
      render :show
    end

  end

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
  
end
