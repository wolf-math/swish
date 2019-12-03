class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @tweets = TwitterApi.perform
  end
end
