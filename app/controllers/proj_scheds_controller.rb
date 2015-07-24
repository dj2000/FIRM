class ProjSchedsController < ApplicationController
  before_action :set_proj_sched, only: [:show, :edit, :update, :destroy]

  # GET /proj_scheds
  # GET /proj_scheds.json
  def index
    @proj_scheds = ProjSched.all
  end

  # GET /proj_scheds/1
  # GET /proj_scheds/1.json
  def show
  end

  # GET /proj_scheds/new
  def new
    @proj_sched = ProjSched.new
  end

  # GET /proj_scheds/1/edit
  def edit
  end

  # POST /proj_scheds
  # POST /proj_scheds.json
  def create
    @proj_sched = ProjSched.new(proj_sched_params)

    respond_to do |format|
      if @proj_sched.save
        format.html { redirect_to @proj_sched, notice: 'Proj sched was successfully created.' }
        format.json { render :show, status: :created, location: @proj_sched }
      else
        format.html { render :new }
        format.json { render json: @proj_sched.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /proj_scheds/1
  # PATCH/PUT /proj_scheds/1.json
  def update
    respond_to do |format|
      if @proj_sched.update(proj_sched_params)
        format.html { redirect_to @proj_sched, notice: 'Proj sched was successfully updated.' }
        format.json { render :show, status: :ok, location: @proj_sched }
      else
        format.html { render :edit }
        format.json { render json: @proj_sched.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proj_scheds/1
  # DELETE /proj_scheds/1.json
  def destroy
    @proj_sched.destroy
    respond_to do |format|
      format.html { redirect_to proj_scheds_url, notice: 'Proj sched was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proj_sched
      @proj_sched = ProjSched.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def proj_sched_params
      params.require(:proj_sched).permit(:project_id, :crew_id, :date, :startTime, :endTime, :notes)
    end
end
