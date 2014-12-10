class Userscontroller < ApplicationController

  def update
    if current_user.update_attributes(user_params)
      notice = "User info updated"
      redirect_to edit_user_registration_path
    else
      alert = "error updating user"
      redirect_to edit_user_registration_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:role)
  end
end
