class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    @clients = Client.all
  end

  def show
    respond_to do |format|
      format.js
      format.html
    end
  end

  def new
    @client = Client.new
    @remote = request.format.symbol == :html ? false : true
  end

  def edit
    @remote = false
  end

  def create
    @property = Property.find(params[:property_id])
    @remote = request.format.symbol == :html ? false : true
    @client = Client.new(client_params)
    respond_to do |format|
      if @client.save
        @property.clients << @client
        format.html { redirect_to @client, notice: 'Client was successfully created.' }
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:firstName, :lastName, :middleInit, :phoneH, :phoneW, :phoneC, :email, :mailAddress)
    end
end
