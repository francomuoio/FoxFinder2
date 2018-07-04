class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_company!
  before_action :check_authorization

  # GET /properties
  # GET /properties.json
  def index
    @properties = Property.where(companies_id: current_company.id)
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
  end

  # GET /properties/new
  def new
    @property = Property.new
    @negociator = Negociator.where(companies_id: current_company.id)
  end

  # GET /properties/1/edit
  def edit
    @negociator = Negociator.where(companies_id: current_company.id)
  end

  # POST /properties
  # POST /properties.json
  def create
    @property = Property.new(property_params)

    respond_to do |format|
      if @property.save
        format.html { redirect_to company_properties_path, notice: 'Property was successfully created.' }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { redirect_to company_properties_path, alert: 'Property creation failed.' }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /properties/1
  # PATCH/PUT /properties/1.json
  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to company_properties_path, notice: 'Property was successfully updated.' }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    @property.destroy
    respond_to do |format|
      format.html { redirect_to company_properties_url, notice: 'Property was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def property_params
       params.require(:property).permit(:property_type, :property_nbr, :property_date, :mandat_type, :mandat_date, :compromis_date, :address, :price, :negociators_id, :companies_id)
    end

    def check_authorization
      company = Company.find_by_id(params[:company_id])
      if (company.id != current_company.id)
        redirect_to companies_path, alert: "Vous n'avez pas les droits requis pour cette action"
      end
    end
end
