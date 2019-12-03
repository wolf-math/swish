class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @tweet_lists = TwitterApi.perform
  end
end
