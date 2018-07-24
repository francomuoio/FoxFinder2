class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update, :destroy, :recherche_adresse, :recherche_type, :recherche_pieces, :recherche_info, :carte_ventes]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_index_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
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
      if (params[:nb_piece] == "5+")
        nb_piece = "5"
      else
        nb_piece = params[:nb_piece]
      end
      @properties = Property.near(params[:location], 0.5, units: :km).where(property_type: params[:room_type], property_nbr: nb_piece)
    else
      redirect_to recherche_adresse_path, notice: "missing args"
    end

    if @properties != nil
      if @properties.size < 10
        if params[:nb_piece] != "5+"
          new_nb_piece = (params[:nb_piece].to_i + 1).to_s
        else
          new_nb_piece = "4"
        end
        @new_properties = Property.near(params[:location], 0.5, units: :km).where(property_type: params[:room_type], property_nbr: new_nb_piece)
        @properties += @new_properties
        if @properties.size < 10
          @new_properties = Property.near(params[:location], 1, units: :km).where(property_type: params[:room_type], property_nbr: new_nb_piece)
        end
       end
      end
      if @properties == nil || @properties.size == 0
          redirect_to sansbien_path
          return
     end
     @companies = []
     @comp = []
     @properties.each do |p|
       @comp += Company.where(id: p.company_id)
     end
     @comp.each do |c|
     end
     @comp.each do |company|
       if (company.siege_id == nil || company.siege == true)
         if !@companies.include?(company)
           get_sells_score(@properties.group_by(&:company), company)
           @companies.push(company)
         end
       else
         company_siege = Company.find_by(id: company.siege_id)
         if !@companies.include?(company_siege)
           get_sells_score(@properties.group_by(&:company), company)
            if company_siege.sells_score == nil || company_siege.sells_score < company.sells_score
                   company_siege.sells_score = company.sells_score
              if company_siege.total_delay > company.total_delay
                company_siege.total_delay = company.total_delay
              end
              company_siege.save
            end
              @companies.push(company_siege)
           end
       end
     end
     @companies.each do |c|
     end
     @companies.sort! { |a, b|  b.sells_score <=> a.sells_score && a.total_delay <=> b.total_delay }
     @companies = @companies.take(3)
     if (@companies.at(0) != nil)
     current_user.first_company_result_id =  @companies.at(0).company_name
    else
     current_user.first_company_result_id = "pas de résultat"
     end
     if (@companies.at(1) != nil)
       current_user.second_company_result_id =  @companies.at(1).company_name
     else
       current_user.second_company_result_id = "pas de résultat"
      end
     if (@companies.at(2) != nil)
       current_user.third_company_result_id = @companies.at(2).company_name
     else
       current_user.third_company_result_id = "pas de résultat"
     end
     current_user.last_search = "#{params[:location]} | #{params[:room_type]} |  #{params[:nb_piece]} pièces"
     current_user.save
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
           date = date / 7
           if ((date = 20 - date) < 0)
             date = 0
           end
           sell_date = (Date.today - p.compromis_date).to_i
           if ((sell_date = sell_date / 7) < 27)
             coefficient = 1
           elsif sell_date >= 27 && sell_date < 55
             coefficient = 0.75
           elsif sell_date >= 55 && sell_date < 79
             coefficient = 0.5
           elsif sell_date >= 79 && sell_date < 108
             coefficient = 0.25
           else
             coefficient = 0
           end
           total_sell_nbr += 1
           total = total + (date * coefficient)
           coef = coef + coefficient
         end
        end
     end
     company.sells_score = (total / coef) + (total_sell_nbr * 0.5).round
     if (company.sells_score > 20)
       company.sells_score = 20
     end
     company.total_delay = total
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

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.fetch(:user, {})
    end
end
