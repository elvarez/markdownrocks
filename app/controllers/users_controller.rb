class UsersController < ApplicationController

  def update
    if current_user.update_attributes(user_params)
      notice = "User info updated"
      redirect_to edit_user_registration_path
    else
      alert = "error updating user"
      redirect_to edit_user_registration_path
    end
  end

  def upgrade
    stripe_card_token = params[:user][:stripe_card_token]
    if customer = Stripe::Customer.create(description: email, plan: role, card: stripe_card_token)
      current_user.update(role: 'premium', stripe_customer_token: customer.id)
      redirect_to root_path, notice: 'Upgraded'
    else
      ...
    end
  end

  private

  def user_params
    params.require(:user).permit(:role)
  end
  
end
