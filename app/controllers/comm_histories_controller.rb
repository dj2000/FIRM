class CommHistoriesController < ApplicationController
  before_action :set_comm_history, only: [:show, :edit, :update, :destroy]

  # GET /comm_histories
  # GET /comm_histories.json
  def index
    @comm_histories = CommHistory.all
  end

  # GET /comm_histories/1
  # GET /comm_histories/1.json
  def show
  end

  # GET /comm_histories/new
  def new
    @comm_history = CommHistory.new
  end

  # GET /comm_histories/1/edit
  def edit
  end

  # POST /comm_histories
  # POST /comm_histories.json
  def create
    @comm_history = CommHistory.new(comm_history_params)

    respond_to do |format|
      if @comm_history.save
        format.html { redirect_to @comm_history, notice: 'Comm history was successfully created.' }
        format.json { render :show, status: :created, location: @comm_history }
      else
        format.html { render :new }
        format.json { render json: @comm_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comm_histories/1
  # PATCH/PUT /comm_histories/1.json
  def update
    respond_to do |format|
      if @comm_history.update(comm_history_params)
        format.html { redirect_to @comm_history, notice: 'Comm history was successfully updated.' }
        format.json { render :show, status: :ok, location: @comm_history }
      else
        format.html { render :edit }
        format.json { render json: @comm_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comm_histories/1
  # DELETE /comm_histories/1.json
  def destroy
    @comm_history.destroy
    respond_to do |format|
      format.html { redirect_to comm_histories_url, notice: 'Comm history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comm_history
      @comm_history = CommHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comm_history_params
      params.require(:comm_history).permit(:inspection_id, :caller, :caller, :recipient, :callSummary, :callOutcome, :callBackDate, :notes)
    end
end
