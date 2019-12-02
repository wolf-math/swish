class PostController < ApplicationController
  def index
    @posts = Post.all
    @professionals_posts = []
    @favorites = current_user.favorites
    @favorites.each do |fav|
      @professionals_posts << fav.professional.posts
    end
    @professional_posts.flatten! unless @professional_posts == nil
  end
end
