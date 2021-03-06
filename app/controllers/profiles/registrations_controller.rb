class Profiles::RegistrationsController < Devise::RegistrationsController
  layout 'application'

  def destroy
    resource.soft_delete

    sign_out_check

    set_flash_message :notice, :destroyed if is_flashing_format?
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end

  private

  def sign_out_check
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
  end

  def account_update_params
    if current_user.super_admin?
      params.require(:user).permit(:email, :password, :password_confirmation, :country, :organisation_id, :current_password)
    else
      params.require(:user).permit(:email, :password, :password_confirmation, :country, :current_password)
    end
  end
end
