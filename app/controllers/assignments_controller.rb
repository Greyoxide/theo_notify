class AssignmentsController < ApplicationController
  before_action :authorize_user

  def index
    @assignments = Assignment.filter_by(params.slice(:by_kind, :by_status, :starts_with)).includes(:person)
  end

  def show
  end

  def new
    respond_to do |format|
      format.js do
        @date = Date.today
        @people = Person.all
        @assignment = Assignment.new
      end

      format.html do
        @date = Date.parse(params[:date].to_s)
        # @assignments = Assignment.where(date: @date)
        @people = Person.all.order(:last_name)
        # @list = PartList.new(@date).items - @assignments.map{ |r| r.title }
        @assignment = Assignment.new
      end
    end

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

  def edit
    @assignment = Assignment.find(params[:id])
    @date = @assignment.date
    @people = Person.all
  end

  def update
    @assignment = Assignment.find(params[:id])
    if @assignment.update(assignment_params)
      respond_to do |format|
        format.html{redirect_to assignments_path}
        format.js{}
      end
    else
      render :edit
    end
  end

  private

  def assignment_params
    params.require(:assignment).permit!
  end

  def filtering_params(params)
    params.slice(:by_kind, :by_status, :starts_with)
  end
end
