class SubjectsController < ApplicationController
  before_action :confirm_logged_in

  def index
    @subjects = Subject.order('position ASC')
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new 
  end

  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      flash[:notice] = 'Subject created'
      redirect_to(subjects_path)
    else
      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def update
    @subject = Subject.find(params[:id])
    if @subject.update(subject_params)
      flash[:notice] = 'Subject updated'
      redirect_to(subject_path(@subject))
    else
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy
    flash[:notice] = 'Subject destroyed'
    redirect_to(subjects_path)
  end

  private

  def subject_params
    params.require(:subject).permit(:name, :visible, :position)
  end
end
