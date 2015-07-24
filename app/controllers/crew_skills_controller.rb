class CrewSkillsController < ApplicationController
  before_action :set_crew_skill, only: [:show, :edit, :update, :destroy]

  # GET /crew_skills
  # GET /crew_skills.json
  def index
    @crew_skills = CrewSkill.all
  end

  # GET /crew_skills/1
  # GET /crew_skills/1.json
  def show
  end

  # GET /crew_skills/new
  def new
    @crew_skill = CrewSkill.new
  end

  # GET /crew_skills/1/edit
  def edit
  end

  # POST /crew_skills
  # POST /crew_skills.json
  def create
    @crew_skill = CrewSkill.new(crew_skill_params)

    respond_to do |format|
      if @crew_skill.save
        format.html { redirect_to @crew_skill, notice: 'Crew skill was successfully created.' }
        format.json { render :show, status: :created, location: @crew_skill }
      else
        format.html { render :new }
        format.json { render json: @crew_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /crew_skills/1
  # PATCH/PUT /crew_skills/1.json
  def update
    respond_to do |format|
      if @crew_skill.update(crew_skill_params)
        format.html { redirect_to @crew_skill, notice: 'Crew skill was successfully updated.' }
        format.json { render :show, status: :ok, location: @crew_skill }
      else
        format.html { render :edit }
        format.json { render json: @crew_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crew_skills/1
  # DELETE /crew_skills/1.json
  def destroy
    @crew_skill.destroy
    respond_to do |format|
      format.html { redirect_to crew_skills_url, notice: 'Crew skill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crew_skill
      @crew_skill = CrewSkill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def crew_skill_params
      params.require(:crew_skill).permit(:crew_id, :skill_id)
    end
end
