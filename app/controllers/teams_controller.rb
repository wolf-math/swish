class TeamsController < ApplicationController
  def index
    @teams = Team.all
    @teams = policy_scope(Team).order(name: :asc)
  end

  def show
    @team = Team.find(params[:id])
    authorize @team
  end

  def team_params
    # team is lookable by items in params
    params.require(:team).permit(:name, :nickname, :abbrevation, :state, :city)
  end
end
