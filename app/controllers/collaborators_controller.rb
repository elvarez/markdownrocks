class CollaboratorsController < ApplicationController

  
def destroy
  @collaborator = Collaborator.find(params[:id])
  authorize @collaborator

  @wiki = @collaborator.wiki
  
  if @collaborator.destroy
    flash[:notice] = 'destruction!'
    redirect_to @wiki
  else
    flash[:alert] = "error deleting"
    redirect_to @wiki
  end

end

def create
  @collaborators = Collaborator.all

  real_params = { :user_id => User.find_by(name: params[:user_name]).id, :wiki_id => collaborator_params[:wiki_id]  }
  
  @collaborator = Collaborator.new(real_params)
  authorize @collaborator

  @wiki = @collaborator.wiki
  error = false
  @collaborators.each do |c|
    if c.user_id == @collaborator.user_id && c.wiki_id == @collaborator.wiki_id
      error = true
    end
  end

  if error
    flash[:notice] = "collaborator already exists"
    redirect_to @wiki
  else
    if @collaborator.save
      flash[:notice] = "New collaborator!"
      redirect_to @wiki
    else
      flash[:error] = "error adding collaborator"
      redirect_to @wiki
    end
  end

end

def collaborator_params
  params.require(:collaborator).permit(:user_name, :wiki_id)
end  
  
end

