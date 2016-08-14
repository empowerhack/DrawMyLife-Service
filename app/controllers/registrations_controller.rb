class RegistrationsController < Devise::RegistrationsController
  def destroy
    resource.soft_delete
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed if is_flashing_format?
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :country, :organisation_id)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :country, :organisation_id, :current_password)
  end
end
