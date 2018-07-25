ActiveAdmin.register AdminUser do
  index do
    selectable_column
    column :email
    column :last_sign_in_at
    actions
  end
end
