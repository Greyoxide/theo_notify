class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update]
  before_action :authorize_user, except: [:show]
  
  def index
    @people = Person.all.order(:last_name)
  end

  def show
    @assignments = @person.assignments.where( "date >= ?", Date.current )
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      redirect_to @person
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @person.update(person_params)
      redirect_to @person
    else
      render :edit
    end
  end


  private

  def person_params
    params.require(:person).permit(:first_name, :last_name, :email)
  end

  def set_person
    @person = Person.friendly.find(params[:id])
  end
end
