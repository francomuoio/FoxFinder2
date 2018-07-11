ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    columns do
      panel "Agences" do
        ul do
          Company.all.map do |post|
            li post.company_name
            ul "negociateur :" do
              post.negociators.map do |negociator|
                li negociator.first_name + ' ' + negociator.last_name
              end
            end
            ul "contrat :" do
              post.properties.map do |property|
                li property.address
            end
            end
        end
      end
    end
  end
end
end
