class CrewsController < ApplicationController
  before_action :set_crew, only: [:show, :edit, :update, :destroy]

  # GET /crews
  # GET /crews.json
  def index
    @crews = Crew.all.paginate(page: params[:page])
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data Crew.as_csv }
    end
  end

  # GET /crews/1
  # GET /crews/1.json
  def show
  end

  # GET /crews/new
  def new
    @crew = Crew.new
  end

  # GET /crews/1/edit
  def edit
  end

  # POST /crews
  # POST /crews.json
  def create
    @crew = Crew.new(crew_params)

    respond_to do |format|
      if @crew.save
        format.html { redirect_to @crew, notice: 'Crew was successfully created.' }
        format.json { render :show, status: :created, location: @crew }
      else
        format.html { render :new }
        format.json { render json: @crew.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /crews/1
  # PATCH/PUT /crews/1.json
  def update
    respond_to do |format|
      if @crew.update(crew_params)
        format.html { redirect_to @crew, notice: 'Crew was successfully updated.' }
        format.json { render :show, status: :ok, location: @crew }
      else
        format.html { render :edit }
        format.json { render json: @crew.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crews/1
  # DELETE /crews/1.json
  def destroy
    @crew.destroy
    respond_to do |format|
      format.html { redirect_to crews_url, notice: 'Crew was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def print
    @crews = Crew.all
    respond_to do |format|
      format.js
    end
  end

  def crew_report
    get_crew_report
    respond_to do |format|
      format.js
    end
  end

  def crew_report_print
    get_crew_report
    respond_to do |format|
      format.js
    end
  end

  def get_crew_report
    start_date = params[:start_date].to_date
    end_date = params[:end_date].to_date
    @proj_scheds = ProjSched.joins(:project => [:contract => [:bid => [ :inspection => [:appointment => [:insp_request => [:property]]]]]]).
                              where('"scheduleStart" BETWEEN ? AND ? ', start_date, end_date).paginate(page: params[:page])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crew
      @crew = Crew.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def crew_params
      params.require(:crew).permit(:foreman, :size, :double_book, :notes, :email)
    end
end
