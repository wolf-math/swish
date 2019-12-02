class PostController < ApplicationController
  def index
    @posts = policy_scope(Post).order(created_at: :desc)
    # @posts = Post.all
    # authorize @posts
    @professionals_posts = []
    @favorites = current_user.favorites
    @favorites.each do |fav|
      @professionals_posts << fav.professional.posts
    end
    @professional_posts.flatten! unless @professional_posts == nil
  end
end
