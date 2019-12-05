class DashboardsController < ApplicationController
  def dashboard
    @myposts = current_user.posts.order(created_at: :desc)
    skip_authorization
  end
end
