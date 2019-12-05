class PeopleController < ApplicationController
  def index
    @people = Person.all
    @people = policy_scope(Person).order(first_name: :asc)
  end

  def show
    @person = Person.find(params[:id])
    authorize @person
  end

  def person_params
    # team is lookable by items in params
    params.require(:person).permit(:first_name, :last_name)
  end
end
