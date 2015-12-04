class ProjSchedsController < ApplicationController
  before_action :set_proj_sched, only: [:show, :edit, :update, :destroy]
  before_action :crews
  before_action :role_required, except: [:report]
  # GET /proj_scheds
  # GET /proj_scheds.json
  def index
    @editable = false
    if params[:id]
      @project = Project.find(params[:id])
      @proj_sched = ProjSched.new
      @editable = true
    end
    if params[:start_date].present? and params[:end_date].present?
      start_date = params[:start_date].to_date
      end_date = params[:end_date].to_date
      @projects = Project.joins(:contract => [:bid => [ :inspection => [:appointment => [:insp_request => [:property]]]]]).
                                where('"scheduleStart" BETWEEN ? AND ? ', start_date, end_date)
    else
      @proj_scheds = ProjSched.where.not(schedule_start_date: nil, schedule_end_date: nil)
    end
    respond_to do |format|
      format.html
      format.json{ render json: @proj_scheds.as_json }
      format.js
    end
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
    respond_to do |format|
      format.js
      format.html
    end
  end

  # POST /proj_scheds
  # POST /proj_scheds.json
  def create
    @proj_sched = ProjSched.new(proj_sched_params)
    @project = Project.find(params[:proj_sched][:project_id])
    respond_to do |format|
      if @proj_sched.save
        format.html { redirect_to @proj_sched, notice: 'Proj sched was successfully created.' }
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  # PATCH/PUT /proj_scheds/1
  # PATCH/PUT /proj_scheds/1.json
  def update
    respond_to do |format|
      if @proj_sched.update(proj_sched_params)
        format.html { redirect_to @proj_sched, notice: 'Proj sched was successfully updated.' }
        format.js
      else
        format.html { render :edit }
        format.js
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

  def scheduled_projects
    if params[:start_date] and params[:end_date]
      @start_day = params[:start_date]
      @end_day = params[:end_date]
    else
      date = params[:date].to_date
      case params[:view_type]
      when "month"
        @start_day = date.beginning_of_month
        @end_day = date.end_of_month
      when "agendaWeek"
        @start_day = date.beginning_of_week(start_day = :monday)
        @end_day = date.end_of_week(end_day = :saturday)
      else
        @start_day = date
        @end_day = date + 1.day
      end
    end
    @proj_scheds =  ProjSched.where('(("schedule_start_date" BETWEEN ? AND ?) OR ("schedule_end_date" BETWEEN ? AND ?)) OR ("schedule_start_date" >= ? OR "schedule_end_date" <= ? )', @start_day, @end_day, @start_day, @end_day, @start_day, @end_day)
    @proj_scheds = @proj_scheds.where(crew_id: params[:crew_id]) if params[:crew_id].present?
    render json: @proj_scheds.as_json
  end

  def print
    start_date = params[:start_date].to_date
    end_date = params[:end_date].to_date
    @projects = Project.joins(:contract => [:bid => [ :inspection => [:appointment => [:insp_request => [:property]]]]]).
                                where('"scheduleStart" BETWEEN ? AND ? ', start_date, end_date)
    respond_to do |format|
      format.js
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proj_sched
      @proj_sched = ProjSched.find(params[:id])
      @project = @proj_sched.try(:project)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def proj_sched_params
      params.require(:proj_sched).permit(:project_id, :crew_id, :startTime, :endTime, :notes, :schedule_start_date, :schedule_end_date)
    end

    def crews
      @crews = Crew.all
    end
end
