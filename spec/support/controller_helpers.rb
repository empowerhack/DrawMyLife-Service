module ControllerHelpers

  def login_as_admin
    login_with_role
  end

  def login_as_org_admin
    login_with_role(:org_admin)
  end

  def login_as_super_admin
    login_with_role(:super_admin)
  end

  private

  def login_with_role(role=:admin)
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user, role)

      sign_in user
    end
  end
end
