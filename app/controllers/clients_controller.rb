class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  before_action :properties
  before_action :role_required

  def index
    if params[:client_id].present?
      @clients = Client.where(id: params[:client_id]).paginate(page: params[:page])
    else
      @clients = Client.all.paginate(page: params[:page])
    end
    @search_clients = Client.all.map{|c| [c.name, c.id]}
    respond_to do |format|
      format.js
      format.html
      format.csv { send_data Client.as_csv }
    end
  end

  def show
    respond_to do |format|
      format.js
      format.html
    end
  end

  def new
    @client = Client.new
    @client_property = ClientProperty.new
    @remote = request.format.symbol == :html ? false : true
  end

  def edit
    @remote = false
  end

  def create
    @property = Property.find(params[:property_id]) if params[:property_id].present?
    @remote = request.format.symbol == :html ? false : true
    @client = Client.new(client_params)
    @client_property = ClientProperty.new
    @clients = @property.try(:clients)  if params[:property_id].present?
    respond_to do |format|
      if @client.save
        @property.clients << @client if params[:property_id].present?
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

  def report
    @clients = Client.where(created_at: (Date.today..Date.today))
  end

  def print
    @clients = Client.all
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    def properties
      @properties = Property.all.map{|p| [p.street, p.id]}
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params[:client][:of_type] = params[:client_of_type]
      params[:client][:client_type] = params[:client][:client_type_other] if params[:client][:client_type] == "Other"
      params.require(:client).permit(:firstName, :lastName, :middleInit, :phoneH, :phoneW, :phoneC, :email, :mailAddress, :is_opt_out_mailer, :client_type, :of_type, :company_name, :notes, :client_type_other)
    end
end
