ActiveAdmin.register Company do
  index do
    selectable_column
    column :id
    column :email
    column :company_name
    column :premium
    column :siege
    column :siege_id
    actions
  end

  show do
    panel 'Détails' do
      attributes_table_for company do
        row :company_name
        row :last_sign_in_at
        row :address
        row :manager_first_name
        row :manager_last_name
      end
    end
    panel 'negociators' do
      table_for company.negociators do
        column :id
        column :first_name
        column :last_name
      end
    end
    panel 'properties' do
      table_for company.properties do
        column :id
        column :address
        column :negociator_id
      end
    end
  end

  form title: 'Agence' do |f|
    f.semantic_errors
    f.inputs 'Details' do
      f.input :email
      f.input :company_name, label: "Nom de l'Agence"
      if action_name != 'edit'
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
      f.inputs 'properties' do
        f.has_many :properties, allow_destroy: true, new_record: false do |b|
          b.input :address
          b.input :negociator_id
        end
      end
      f.inputs 'negociators' do
        f.has_many :negociators, allow_destroy: true, new_record: false do |b|
          b.input :first_name
          b.input :last_name
        end
      end
    end
    f.inputs 'Siege' do
      f.collection_select :siege_id, Company.all, :id, :company_name, include_blank: true, value_method: :company_name
      f.input :siege
    end
    inputs 'Premium' do
      input :premium
    end
    actions
  end

  permit_params :email, :company_name, :manager_first_name, :manager_last_name, :address, :siret,
                :pro_card_nbr, :phone, :website, :description, :photo, :cover, :siege_id, :premium, :password, :password_confirmation, :siege, sub_company_attributes: [:siege_id]
end
