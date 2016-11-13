class Profiles::ConfirmationsController < Devise::ConfirmationsController
  # Remove the first skip_before_filter (:require_no_authentication) if you
  # don't want to enable logged users to access the confirmation page.
  skip_before_filter :require_no_authentication
  skip_before_filter :authenticate_user!

  # POST /resource/confirmation
  def create
    self.resource = resource_class.send_confirmation_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      set_flash_message :notice, :send_instructions
      respond_with({}, location: root_path)
    else
      respond_with(resource)
    end
  end

  # PUT /resource/confirmation
  def update
    with_unconfirmed_confirmable do
      if @confirmable.has_no_password?
        @confirmable.attempt_set_password(params[:user])
        if @confirmable.valid?
          do_confirm
        else
          do_show
          set_flash_message :notice, :password_update_failure
          @confirmable.errors.clear #so that we wont render :new
        end
      else
        @confirmable.errors.add(:email, :password_already_set)
      end
    end

    if !@confirmable.errors.empty?
      self.resource = @confirmable
      render 'profiles/confirmations/new' #Change this if you don't have the views on default path
    end
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    with_unconfirmed_confirmable do
      if @confirmable.has_no_password?
        do_show
      else
        do_confirm
      end
    end
    unless @confirmable.errors.empty?
      self.resource = @confirmable
      render 'profiles/confirmations/new' #Change this if you don't have the views on default path
    end
  end

  protected

  def with_unconfirmed_confirmable
    confirmation_token = params[:confirmation_token] || params[:user].fetch(:confirmation_token)
    @confirmable = User.find_or_initialize_with_error_by(:confirmation_token, confirmation_token)

    if !@confirmable.new_record?
      @confirmable.only_if_unconfirmed {yield}
    end
  end

  def do_show
    confirmation_token = params[:confirmation_token] || params[:user].fetch(:confirmation_token)
    @confirmable = User.find_or_initialize_with_error_by(:confirmation_token, confirmation_token)
    @requires_password = true
    self.resource = @confirmable
    render 'profiles/confirmations/show' #Change this if you don't have the views on default path
  end

  def do_confirm
    @confirmable.confirm
    set_flash_message :notice, :confirmed
    sign_in_and_redirect(resource_name, @confirmable)
  end
end
