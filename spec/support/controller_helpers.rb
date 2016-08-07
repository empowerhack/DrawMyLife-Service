module ControllerHelpers
  def login_admin
    login_with_scope(:admin)
  end

  def login_user
    login_with_scope(:user)
  end

  private

  def login_with_scope(scope=:user)
    before do
      @request.env["devise.mapping"] = Devise.mappings[scope]
      user = FactoryGirl.create(scope)

      if scope == :user
        sign_in user
      else
        sign_in :user, user
      end
    end
  end
end
