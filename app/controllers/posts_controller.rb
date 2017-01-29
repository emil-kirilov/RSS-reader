class PostsController < ApplicationController
	def index
		@posts = Post.all
	end

	def ordered_index
		Feed.refresh_posts
		@posts = Post.order('posts.pub_date DESC').all
	end

	def destroy
		@post = Post.find params[:id]

		if @post.delete
      flash[:notice] = "The post was deleted successfully."
      redirect_to posts_path
    else
      flash[:error] = "The post was not deleted."
      redirect_to posts_path
    end
	end
end