class PlayerFollowsController < ApplicationController

  def new
    @people = Person.all
    # @teams = policy_scope(Team).order(name: :asc)
    @follow = Follow.new #just for the form
    authorize @follow
  end

  def create
    params[:follow][:person_ids].delete("")
    params[:follow][:person_ids].each do |id|
      @person = Person.find(id)
      if !current_user.following?(@person)
        current_user.follow(@person)
      end
    end

    authorize Follow
    redirect_to root_path
  end

  def update
  end

  def show
    # @team = Team.find(params[:id])
  end

  def team_params
    # team is lookable by items in params
    params.require(:person).permit(:first_name, :last_name, :jersey_number, :position, :height, :team_id)
  end
end
