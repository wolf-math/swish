class StandingsController < ApplicationController
    def index
    @teams = Team.all
    @teams = policy_scope(Team)
    @east = @teams.where(conference: "east").order(standing: :asc)
    @west = @teams.where(conference: "west").order(standing: :asc)
  end
end
