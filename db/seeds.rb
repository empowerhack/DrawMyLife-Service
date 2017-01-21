# Run me with rake db:seed

organisation = Organisation.create(name: "EmpowerHack")


# Super Admin
User.create!(
  email: "super_admin@example.com",
  password: "password",
  password_confirmation: "password",
  country: "RS",
  role: "super_admin",
  confirmed_at: Time.zone.now
)

# Admin
User.create!(
  email: "admin@example.com",
  password: "password",
  password_confirmation: "password",
  country: "RS",
  organisation: organisation,
  role: "admin",
  confirmed_at: Time.zone.now
)
