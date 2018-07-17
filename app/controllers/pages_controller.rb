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
 end

 def carte_ventes
   store_params_in_session
   if params[:room_type].present? && params[:location].present? && params[:nb_piece].present?
     @properties = Property.near(params[:location], 0.5, units: :km).where(property_type: params[:room_type], property_nbr: params[:nb_piece])
   else
     redirect_to recherche_adresse_path
   end
   if @properties != nil
     if @properties.size == 0
       @properties = Property.near(params[:location], 1, units: :km).where(property_type: params[:room_type], property_nbr: params[:nb_piece])
       if @properties.size == 0
         redirect_to sansbien_path
         return
       end
     else
       @properties.each do |property|
         Rails.logger.debug("Property ==")
         Rails.logger.debug(property.address)
       end
       @companies = Company.where(id: @properties.reorder(:company_id).pluck(:company_id))
       @companies.each do |company|
        get_sells_score(@properties.group_by(&:company), company)
       end
     end
   end
 end

 private

   def get_sells_score(properties, company)
     total = 0
     coef = 0
     total_sell_nbr = 0
     properties.each do |k, v|
       v.each do |p|
         if company.id == p.company_id
           date = (p.compromis_date - p.mandat_date).to_i
           if ((date = date / 7) < 27)
             p.coefficient = 1
           elsif date >= 27 && date < 55
             p.coefficient = 0.75
           elsif date >= 55 && date < 79
             p.coefficient = 0.5
           elsif date >= 79 && date < 108
             p.coefficient = 0.25
           else
             p.coefficient = 0
           end
           if ((date = 20 - date) < 0)
             date = 0
           end
           total_sell_nbr += 1
           Rails.logger.debug("Date =")
           Rails.logger.debug(date)
           total = total + (date * p.coefficient)
           coef = coef + p.coefficient
         end
      end
     end
     Rails.logger.debug("Company sells_score avant =")
     Rails.logger.debug(company.sells_score = (total / coef) + (total_sell_nbr * 0.5).round)
     if (company.sells_score > 20)
       company.sells_score = 20
     end
     Rails.logger.debug("La note final est de :")
     Rails.logger.debug(company.sells_score)
     company.total_delay = total
     company.sells_score
     company.save
   end

   def store_params_in_session
      session[:last_search] = {
        location: params[:location],
        room_type: params[:room_type],
        nb_piece: params[:nb_piece]
        # .. add more params here if needed
      }
    end
end
