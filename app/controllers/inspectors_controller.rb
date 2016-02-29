class InspectorsController < ApplicationController
  before_action :set_inspector, only: [:show, :edit, :update, :destroy]
  before_action :role_required
  # GET /inspectors
  # GET /inspectors.json
  def index
    @inspectors = Inspector.all.paginate(page: params[:page])
     respond_to do |format|
      format.js
      format.html
      format.csv { send_data Inspector.as_csv }
    end
  end

  # GET /inspectors/1
  # GET /inspectors/1.json
  def show
  end

  # GET /inspectors/new
  def new
    @inspector = Inspector.new
    states_cities
  end

  # GET /inspectors/1/edit
  def edit
    states_cities
  end

  # POST /inspectors
  # POST /inspectors.json
  def create
    @inspector = Inspector.new(inspector_params)
    states_cities
    respond_to do |format|
      if @inspector.save
        format.html { redirect_to @inspector, notice: 'Inspector was successfully created.' }
        format.json { render :show, status: :created, location: @inspector }
      else
        format.html { render :new }
        format.json { render json: @inspector.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inspectors/1
  # PATCH/PUT /inspectors/1.json
  def update
    states_cities
    respond_to do |format|
      if @inspector.update(inspector_params)
        format.html { redirect_to @inspector, notice: 'Inspector was successfully updated.' }
        format.json { render :show, status: :ok, location: @inspector }
      else
        format.html { render :edit }
        format.json { render json: @inspector.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inspectors/1
  # DELETE /inspectors/1.json
  def destroy
    @inspector.destroy
    respond_to do |format|
      format.html { redirect_to inspectors_url, notice: 'Inspector was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def print
    @inspectors = Inspector.all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inspector
      @inspector = Inspector.find(params[:id])
    end

    def states_cities
      @states = CS.states(:us).collect{|k, v| [v, k.to_s] }
      @cities = @inspector.state ? CS.cities((@inspector.state).to_sym, :us) : []
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inspector_params
      params.require(:inspector).permit(:firstName, :lastName, :middleInit, :senior, :phoneH, :phoneC, :address, :city, :state, :zip, :email, :notes, :is_active)
    end
end
