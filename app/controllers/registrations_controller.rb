class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :country)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :country, :current_password)
  end
end
