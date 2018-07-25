class NegociatorsController < ApplicationController
  before_action :set_negociator, only: %i[show edit update destroy]
  before_action :authenticate_company!
  before_action :check_authorization

  # GET /negociators
  # GET /negociators.json
  def index
    @negociators = current_company.negociators
  end

  # GET /negociators/1
  # GET /negociators/1.json
  def show; end

  # GET /negociators/new
  def new
    @negociator = Negociator.new
  end

  # GET /negociators/1/edit
  def edit; end

  # POST /negociators
  # POST /negociators.json
  def create
    @negociator = Negociator.new(negociator_params)

    respond_to do |format|
      if @negociator.save
        format.html { redirect_to company_negociators_path, notice: 'Negociator was successfully created.' }
        format.json { render :show, status: :created, location: @negociator }
      else
        format.html { render :new }
        format.json { render json: @negociator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /negociators/1
  # PATCH/PUT /negociators/1.json
  def update
    respond_to do |format|
      if @negociator.update(negociator_params)
        format.html { redirect_to company_negociators_path, notice: 'Negociator was successfully updated.' }
        format.json { render :show, status: :ok, location: @negociator }
      else
        format.html { render :edit }
        format.json { render json: @negociator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /negociators/1
  # DELETE /negociators/1.json
  def destroy
    Property.where(negociator_id: @negociator.id).destroy_all
    @negociator.destroy
    respond_to do |format|
      format.html { redirect_to company_negociators_path, notice: 'Negociator was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_negociator
    @negociator = Negociator.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def negociator_params
    params.require(:negociator).permit(:first_name, :last_name, :company_id)
  end

  def check_authorization
    company = Company.find_by_id(params[:company_id])
    if company.id != current_company.id
      redirect_to company_path(current_company.id), alert: "Vous n'avez pas les droits requis pour cette action"
    end
end
end
