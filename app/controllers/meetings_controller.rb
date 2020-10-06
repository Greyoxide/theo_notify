class MeetingsController < ApplicationController
  before_action :authorize_user, except: [:show]
  def new
		# @date = Date.parse(params[:date].to_s)
		# @assignments = Assignment.where(date: @date)
		# @list = PartList.new(@date).items - @assignments.map{ |r| r.title }
		# @people = Person.all.order(:last_name)

    # @meeting = Meeting.new(date: Date.parse(params[:date].to_s))
  #   @assignments = Assignment.where(date: @date)
  #   @list = PartList.new(@date).items - @assignments.map{ |r| r.title }
  #     @people = Person.all.order(:last_name)

    @date = Date.parse(params[:date].to_s)
    @assignments = Assignment.where(date: @date)
    @list = PartList.new(@date).items - @assignments.map{ |r| r.title }

    @list.each do |item|
      Assignment.create!(date: @date, title: item, kind: 'primary_part')
    end

    redirect_to edit_meeting_path(@date)
  end

  def edit
    @date = Date.parse(params[:date].to_s)
    @assignments = Assignment.where(date: @date)
    @people = Person.all
  end

	def show
		@date = Date.parse( params[:date] )
		@assignments = Assignnment.where(date: @date)
	end

  private

  def meeting_params
    params.require(:meeting).permit(:date, assignments_params: [ :_destroy, :id, :person_id, :date, :kind, :title ])
  end
end
