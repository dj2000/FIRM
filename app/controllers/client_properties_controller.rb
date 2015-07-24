class ClientPropertiesController < ApplicationController
  before_action :set_client_property, only: [:show, :edit, :update, :destroy]

  # GET /client_properties
  # GET /client_properties.json
  def index
    @client_properties = ClientProperty.all
  end

  # GET /client_properties/1
  # GET /client_properties/1.json
  def show
  end

  # GET /client_properties/new
  def new
    @client_property = ClientProperty.new
  end

  # GET /client_properties/1/edit
  def edit
  end

  # POST /client_properties
  # POST /client_properties.json
  def create
    @client_property = ClientProperty.new(client_property_params)

    respond_to do |format|
      if @client_property.save
        format.html { redirect_to @client_property, notice: 'Client property was successfully created.' }
        format.json { render :show, status: :created, location: @client_property }
      else
        format.html { render :new }
        format.json { render json: @client_property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /client_properties/1
  # PATCH/PUT /client_properties/1.json
  def update
    respond_to do |format|
      if @client_property.update(client_property_params)
        format.html { redirect_to @client_property, notice: 'Client property was successfully updated.' }
        format.json { render :show, status: :ok, location: @client_property }
      else
        format.html { render :edit }
        format.json { render json: @client_property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_properties/1
  # DELETE /client_properties/1.json
  def destroy
    @client_property.destroy
    respond_to do |format|
      format.html { redirect_to client_properties_url, notice: 'Client property was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_property
      @client_property = ClientProperty.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_property_params
      params.require(:client_property).permit(:client_id, :property_id, :clientType, :typeDate, :occupiedBy, :escrow, :escrowDate)
    end
end
