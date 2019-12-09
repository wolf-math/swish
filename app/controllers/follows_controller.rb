class FollowsController < ApplicationController

  def new
    @teams = Team.all
    # @teams = policy_scope(Team).order(name: :asc)
    @follow = Follow.new #just for the form
    authorize @follow
  end

  def create
    params[:follow][:team_ids].delete("")
    params[:follow][:team_ids].each do |id|
      @team = Team.find(id)
      if !current_user.following?(@team)
        current_user.follow(@team)
      end
    end

    authorize Follow
    redirect_to new_player_follow_path
  end

  def update
  end

  def show
    # @team = Team.find(params[:id])
  end

  def team_params
    # team is lookable by items in params
    params.require(:team).permit(:name, :nickname, :abbrevation, :state, :city)
  end
end
