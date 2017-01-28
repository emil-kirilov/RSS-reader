class FeedsController < ApplicationController
	def new
		@feed = Feed.new
	end

	def create
		@feed = Feed.new(feed_params)

		if legit @feed and @feed.save
			flash[:notice] = 'The new feed was successfully added.'
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
	end

	def edit
	end

	def update
	end

	def feed_params
		params.require(:feed).permit(:url)
	end
end