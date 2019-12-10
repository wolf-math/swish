class DashboardsController < ApplicationController
  def dashboard
    skip_authorization
    @myposts = current_user.posts.order(created_at: :desc)
    @comments = current_user.comments.order(created_at: :desc)
    @teams = current_user.follows.where(followable_type: "Team")
    @players = current_user.follows.where(followable_type: "Person")
  end
end
