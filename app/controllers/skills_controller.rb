class SkillsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]

  # def new
  #   @skill = Skill.new
  # end

  def create
    skill = Skill.new(skill_params)
    skill.user_id = current_user.id
    if skill.save
      redirect_to request.referer
    else
      redirect_to :action => "new"
    end
  end

  def edit
    @skill = Skill.find(params[:id])
    respond_to do |format|
      format.html{}
      format.js {}
    end
  end

  # def create
  #   @form = Form::SkillCollection.new(skill_collection_params)
  #   if @form.save
  #     redirect_to user_path(current_user.id), notice: "言語を登録しました"
  #   else
  #     flash.now[:alert] = "言語登録に失敗しました"
  #     render :new
  #   end
  # end

  def update
    respond_to do |format|

      skill = Skill.find(params[:id])
      if skill.update(skill_params)
        format.html {}
        format.json {}

        redirect_to request.referer, :id => skill.id
      else
        format.html {  }
        format.json {  }

        redirect_to :action => "new"
      end
    end

  end

  def destroy
    skill = Skill.find(params[:id])
    skill.destroy
    redirect_to user_path(current_user.id)
  end

  private
  def skill_params
    params.require(:skill).permit(:language_name, :evaluation, :image, :user_id)
  end

end
