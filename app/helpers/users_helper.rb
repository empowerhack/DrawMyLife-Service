module UsersHelper
  def form_title
    @user.new_record? ? "Add User" : "Edit User"
  end

  def radio_roles
    # Example output: [ ["superadmin", "Super Admin"], ["admin", "Admin"] ]
    [].tap do |arr|
      User.roles.keys.each { |s| arr << [s, s.humanize] }
    end
  end
end
