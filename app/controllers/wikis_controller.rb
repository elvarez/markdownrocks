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
      flash[:notice] = "created!"
      redirect_to @wiki
    else
      flash[:notice] = "error creating"
      render 'index'
    end
  end

  def edit
    @users = User.all
    @wiki = Wiki.find(params[:id])
    @collaborator = Collaborator.new
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.update_attributes(params.require(:wiki).permit(:title, :body, :private))
      flash[:notice] = "Updated!"
      redirect_to @wiki
    else
      flash[:error] = "error saving the post"
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.destroy
      flash[:notice] = "destroyed!"
      redirect_to wikis_path
    else
      flash[:error] = "error deleting"
      render :show
    end

  end

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
  
end
