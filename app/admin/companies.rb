ActiveAdmin.register Company do
  index do
    selectable_column
    column :email
    column :last_sign_in_at
    actions
  end

  form title: 'Crée une agence' do |f|
    f.semantic_errors
  inputs 'Details' do
    input :email
    input :company_name, label: "Nom de l'Agence"
    input :password
    input :password_confirmation
    input :manager_first_name
    input :manager_last_name
    input :address
    input :siret
    input :pro_card_nbr
    input :phone
    input :company_type
    input :website
    input :description
    input :photo
    input :cover
  end
  inputs 'Siege' do
    input :siege_id
    input :siege

  end
  inputs 'Premium' do
    input :premium
    input :role
  end
  actions
end
permit_params :email, :company_name, :manager_first_name, :manager_last_name, :address, :siret, :pro_card_nbr, :phone, :company_type, :website, :description, :photo, :cover, :siege_id, :siege, :premium, :role, :password, :password_confirmation

end
