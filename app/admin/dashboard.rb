ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    Company.all.map do |post|
      columns do
        panel post.company_name.to_s do
          ul do
            ul 'negociateur :' do
              post.negociators.map do |negociator|
                ul 'contrat de ' + negociator.first_name + ' ' + negociator.last_name + ' :' do
                  negociator.property.map do |p|
                    li p.address
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
