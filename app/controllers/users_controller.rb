class UsersController < ApplicationController

  def update
    current_user.stripe_card_token = params[:user][:stripe_card_token]

    if customer = Stripe::Customer.create(description: current_user.email, plan: 1, card: current_user.stripe_card_token)
      current_user.update_attributes(role: 'premium', stripe_customer_token: customer.id)
      redirect_to root_path, notice: 'Upgraded'
    else
      redirect_to edit_user_path
    end
  end

  def downgrade    
    if Stripe::Customer.retrieve(current_user.stripe_customer_token).subscriptions.first.delete
      current_user.update_attributes(role: "standard")
      redirect_to root_path, notice: "downgraded"
    else
      redirect_to edit_user_path
    end
  end

  def regrade
    if Stripe::Customer.retrieve(current_user.stripe_customer_token).subscriptions.create(:plan => 1)
      current_user.update_attributes(role: "premium")
      redirect_to root_path, notice: "Upgraded"
    else
      redirect_to edit_user_path
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:role, :stripe_card_token)
  end
  
end
