class AddAdmin < ActiveRecord::Migration[7.0]
  def change
    User.create! do |u|
      u.email = 'edu_admin@gmail.com'
      u.password = '123456'
      u.password_confirmation = '123456'
      u.name = 'Eduardo'
      u.surname = 'Garcia'
      u.dni = '12345678'
      u.phone = '0221555555'
      u.admin_role = true
      u.user_role = false
    end
  end
end
