class FeedsController < ApplicationController
	def new
		@feed = Feed.new
	end

	def create
		@feed = Feed.new(feed_params)

		if legit @feed and @feed.save
			flash[:notice] = 'The new feed was successfully added.'
			save_posts @feed
			redirect_to feeds_path
		else
			flash.now[:error] = 'You have either entered an invalid link or you already receive news from this RSS feeder.'
			render :new
		end
	end

	def index
		@feeds = Feed.all
	end

	def destroy
		@feed = Feed.find params[:id]

		if @feed.destroy
      flash[:notice] = "The feed was deleted successfully."
      flash[:notice] << "All releted posts were deleted."
    else
      flash[:error] = "The feed was not deleted."
    end
    redirect_to feeds_path
	end

	def edit
		 @feed = Feed.find(params[:id])  
	end

	def update
    @feed = Feed.find(params[:id])
    @feed.url = feed_params[:url]
    if @feed.save
    	flash[:notice] = "The feed was updated successfully."
    	#TODO - check whether the url is not the same
    	destroy_related_posts @feed
    	save_posts @feed

      redirect_to feeds_path
    else
    	flash[:error] = "The feed could not be updated. Either an invalid or already existing url has been provided."
      redirect_to edit_feed_path @feed
    end
	end

	def feed_params
		params.require(:feed).permit(:url)
	end
end