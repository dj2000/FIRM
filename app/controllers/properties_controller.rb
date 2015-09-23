class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy]
  before_action :validate_info

  def index
    @properties = Property.all
  end

  def show
    respond_to do |format|
      format.js
      format.html
    end
  end

  def new
    @property = Property.new
    @remote = request.format.symbol == :html ? false : true
    states_cities
  end

  def edit
    @remote = false
    states_cities
  end

  def create
    @property = Property.create(property_params)
    @remote = request.format.symbol == :html ? false : true
    states_cities
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to @property, notice: 'Property was successfully created.' }
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to @property, notice: 'Property was successfully updated.' }
        format.json { render json: @property }
      else
        format.html { render :edit }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @property.destroy
    respond_to do |format|
      format.html { redirect_to properties_url, notice: 'Property was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    def validate_info
      @zip_codes = SvcArea.where(serviced: true).map{|z| [z.zip, z.zip]}
      @svc_criterium = SvcCriterium.where(propRes: true).first
      @year = @svc_criterium.try(:yearBuilt)
      @years = (1901..@year).map{|y| [y, y]}
      @foundation_type = @svc_criterium.try(:foundation)
    end

    def states_cities
      @states = CS.states(:us).collect{|k, v| [v, k.to_s] }
      @cities = @property.state ? CS.cities((@property.state).to_sym, :us) : []
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def property_params
      params.require(:property).permit(:number, :street, :city, :state, :zip, :crossStreet, :mapPage, :yearBuilt, :size, :stories, :type, :units, :gndUnits, :lotType, :foundation, :prop_type, :occupied_by, :cdo, :hpoz)
    end
end
