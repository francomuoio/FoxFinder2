class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home], raise: false

  def home
  end
  def recherche_adresse
   store_params_in_session
 end

 def recherche_type
   store_params_in_session
 end

 def recherche_pieces
   store_params_in_session
 end

 def recherche_info
     store_params_in_session
     @property = Property.near(params[:location], 1, units: :km).where(property_type: params[:room_type], property_nbr: params[:nb_piece])
     @company = Company.where(id: @property.reorder(:company_id).pluck(:company_id), premium: true)
     @company.each do |company|
       company.delai = result_delai(@property.group_by(&:company), company)
       company.save
     end
   end

   def carte_ventes
     store_params_in_session
   if params[:room_type].present? && params[:location].present? && params[:nb_piece].present?
     @properties = Property.near(params[:location], 1, units: :km).where(property_type: params[:room_type], property_nbr: params[:nb_piece])
   end
   if @properties.size == 0
     redirect_to sansbien_path
     return
   else
     @company = current_user
     @companies = Company.where(id: @properties.reorder(:company_id).pluck(:company_id))
     @companies.each do |company|
       company.delai = result_delai(@properties.group_by(&:company), company)
       company.area_ventes = ventes_area_size(@properties.group_by(&:company), company)
       company.delai_score = calc_delai_score(company)
       company.delai_simple = delai_simple(@properties.group_by(&:company), company)
       company.delai_exclu = delai_exclusif(@properties.group_by(&:company), company)
       company.ratio_nego = calc_ratio_nego(company)
       company.score_ventes = result_date_ventes(@properties.group_by(&:company), company)
       company.score_final = calc_final_score(company.score_ventes, ventes_area_size(@properties.group_by(&:company), company))
       company.save
     end

     validbiens = []
     @properties.each do |b|
       if b.company.siege == false
         validbiens << b
       end
     end

     validcompanies = []
     @companies.order("delai ASC").limit(3).each do |u|
       if u.admin == false
         # UserMailer.recomandation(u, params[:nom], params[:prenom], params[:room_type], params[:location]).deliver_now
       end
       validcompanies << u
     end


     @hash = Gmaps4rails.build_markers(validbiens) do |bien, marker|
       marker.lat bien.latitude
       marker.lng bien.longitude
       marker.picture({
         :url => ActionController::Base.helpers.asset_path("markers/bien16.png"),
         "width" =>  8,
         "height" => 8})
         if bien.delai > 1
           marker.infowindow gmaps4rails_infowindow(bien)
         else
           marker.infowindow gmaps4rails_infowindow_single(bien)
         end
       end
     end
   end

   private

   def store_params_in_session
      session[:last_search] = {
        location: params[:location],
        room_type: params[:room_type],
        nb_piece: params[:nb_piece]
        # .. add more params here if needed
      }
    end
end
