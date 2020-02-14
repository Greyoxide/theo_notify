class MeetingsController < ApplicationController
  before_action :authorize_user, except: [:show]
  def new
		@date = Date.parse(params[:date].to_s)
		@assignments = Assignment.where(date: @date)
		@list = PartList.new(@date).items - @assignments.map{ |r| r.title }
		@people = Person.all.order(:last_name)
  end

	def show
		@date = Date.parse( params[:date] )
		@assignments = Assignnment.where(date: @date)
	end
end
