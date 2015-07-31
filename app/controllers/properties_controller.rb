class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy]

  def index
    @properties = Property.all
  end

  def show
  end

  def new
    @property = Property.new
    states_cities
  end

  def edit
  end

  def create
    @property = Property.create(property_params)
    states_cities if @property.errors.present?
  end

  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to @property, notice: 'Property was successfully updated.' }
        format.json { render :show, status: :ok, location: @property }
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

  def cities
    state = params[:state]
    @cities = CS.cities(state.to_sym, :us)
    render json: @cities
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
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
