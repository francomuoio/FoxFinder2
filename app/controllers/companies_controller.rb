class CompaniesController < ApplicationController
  before_action :authenticate_company!, only: %i[edit update destroy]
  before_action :set_company, only: %i[show edit update destroy]
  before_action :check_authorization, only: %i[edit update destroy]

  # GET /companies
  # GET /companies.json
  def index
    @company = Company.where(id: current_company.id)
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @property = @company.properties
    @negociator = @company.negociators
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit; end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Companies was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Companies was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    Property.where(company_id: @company.id).destroy_all
    Negociator.where(company_id: @company.id).destroy_all
    @company.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_company
    @company = Company.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def company_params
    params.fetch(:company, {})
  end

  def check_authorization
    if @company.id != current_company.id
      redirect_to company_path(current_company.id), alert: "Vous n'avez pas les droits requis pour cette action"
    end
  end
end
