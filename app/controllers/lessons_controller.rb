class LessonsController < ApplicationController
  def index
    @lessons = Lesson.all
  end

  def show
    @section = Section.find(params[:section_id])
    @lesson = Lesson.find(params[:id])
  end

  def new
    @section = Section.find(params[:section_id])
    @lesson = Lesson.new
  end

  def create
    @section = Section.find(params[:section_id])
    @lesson = @section.lessons.new(lesson_params)
    if @lesson.save
      flash[:notice]="You added a lesson!"
      redirect_to section_path(@lesson.section)
    else
      flash[:alert]="You didn't add the lesson... keep practicing!"
      render :new
    end
  end

  def edit
    @section = Section.find(params[:section_id])
    @lesson = Lesson.find(params[:id])
  end

  def update
    @section = Section.find(params[:section_id])
    @lesson = Lesson.find(params[:id])
    if @lesson.update(lesson_params)
      flash[:notice]="You added a lesson!"
      redirect_to section_lessons_path
    else
      flash[:alert]="You didn't add the lesson... keep practicing!"
      render :edit
    end
  end

  def destroy
    @lesson = Lesson.find(params[:id])
    @lesson.destroy
    redirect_to sections_path
  end

  private
  def lesson_params
    params.require(:lesson).permit(:name, :content, :number, :image)
  end
end
