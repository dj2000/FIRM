class InspSkillsController < ApplicationController
  before_action :set_insp_skill, only: [:show, :edit, :update, :destroy]

  # GET /insp_skills
  # GET /insp_skills.json
  def index
    @insp_skills = InspSkill.all
  end

  # GET /insp_skills/1
  # GET /insp_skills/1.json
  def show
  end

  # GET /insp_skills/new
  def new
    @insp_skill = InspSkill.new
  end

  # GET /insp_skills/1/edit
  def edit
  end

  # POST /insp_skills
  # POST /insp_skills.json
  def create
    @insp_skill = InspSkill.new(insp_skill_params)

    respond_to do |format|
      if @insp_skill.save
        format.html { redirect_to @insp_skill, notice: 'Insp skill was successfully created.' }
        format.json { render :show, status: :created, location: @insp_skill }
      else
        format.html { render :new }
        format.json { render json: @insp_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /insp_skills/1
  # PATCH/PUT /insp_skills/1.json
  def update
    respond_to do |format|
      if @insp_skill.update(insp_skill_params)
        format.html { redirect_to @insp_skill, notice: 'Insp skill was successfully updated.' }
        format.json { render :show, status: :ok, location: @insp_skill }
      else
        format.html { render :edit }
        format.json { render json: @insp_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /insp_skills/1
  # DELETE /insp_skills/1.json
  def destroy
    @insp_skill.destroy
    respond_to do |format|
      format.html { redirect_to insp_skills_url, notice: 'Insp skill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_insp_skill
      @insp_skill = InspSkill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def insp_skill_params
      params.require(:insp_skill).permit(:inspector_id, :skill_id)
    end
end
