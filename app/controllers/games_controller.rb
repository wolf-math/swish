class GamesController < ApplicationController
  def index
    @games = policy_scope(Game).order(date: :desc)
    today = Date.today
    @today_game = Game.all.where(date: today)
    yesterday = Date.yesterday
    @yesterday_game = Game.all.where(date: yesterday)
    @this_week = Game.all.where(date: today.cweek)
    @arr = @games.group_by(&:date_time)
  end

  def show
    @game = Game.find(params[:id])
    authorize @game
  end
end
