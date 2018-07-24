ActiveAdmin.register User do
  index do
    selectable_column
    column :id
    column :email
    actions
  end

  show do
    attributes_table :id, :name, :email

    panel "Dernière recherche" do
      table_for user do
        column :last_search
        column :first_company_result_id
        column :second_company_result_id
        column :third_company_result_id
      end
    end
  end



  form title: 'User' do |f|
    f.semantic_errors
    f.inputs 'Details' do
      f.input :email
      f.input :name
      if action_name != "edit"
        f.input :password
        f.input :password_confirmation
      end
    end
    actions
  end

permit_params :email, :password, :password_confirmation

end
