ActiveAdmin.register Company do
  index do
    selectable_column
    column :email
    column :last_sign_in_at
    actions
  end

  form title: 'Crée une agence' do |f|
    f.semantic_errors
  f.inputs 'Details' do
    f.input :email
    f.input :company_name, label: "Nom de l'Agence"
    if action_name != "edit"
      f.input :password
      f.input :password_confirmation
    end
    f.input :manager_first_name
    f.input :manager_last_name
    f.input :address
    f.input :siret
    f.input :pro_card_nbr
    f.input :phone
    f.input :website
    f.input :description
    f.input :photo
    f.input :cover
  end
  f.inputs 'Siege' do
      f.collection_select :siege_id,Company.all, :id, :company_name, :include_blank => false, :value_method => :company_name
  end
  inputs 'Premium' do
    input :premium
  end
  actions
end
permit_params :email, :company_name, :manager_first_name, :manager_last_name, :address, :siret,
  :pro_card_nbr, :phone, :website, :description, :photo, :cover, :siege_id, :premium, :password, :password_confirmation, sub_company_attributes: [:siege_id]

end
