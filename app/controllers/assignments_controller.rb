class AssignmentsController < ApplicationController
  before_action :authorize_user

  def index
		@assignments = Assignment.filter(params.slice(:date_range, :kind)).order(date: :asc)
  end

  def show
  end

  def new
    @date = Date.parse(params[:date].to_s)
    @assignments = Assignment.where(date: @date)
    @people = Person.all
    @list = PartList.new(@date).items - @assignments.map{ |r| r.title }
    @assignment = Assignment.new
  end

  def create

    @assignment = Assignment.new(assignment_params)
    respond_to do |format|
      format.js do
        @assignment.save
      end
      format.html do
        if @assignment.save
          flash[:success] = 'Part assigned'
          redirect_to assignments_path
        else
          @date = @assignment.date
          @assignments = Assignment.where(date: @date)
          @list = PartList.new(@date).items - @assignments.map{ |r| r.title }
          @people = Person.all
          flash[:error] = 'Something went wrong, lets try that again'
          render :new
        end
      end
    end
  end

  private

  def assignment_params
    params.require(:assignment).permit!
  end
end
