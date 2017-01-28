class FeedsController < ApplicationController
	def new
		@feed = Feed.new
	end

	def create
		@feed = Feed.new(feed_params)

		#unless legit @feed 
		#	flash[:notice] = 'Invalid'
		#end

		if legit @feed and @feed.save
			flash[:notice] = 'The new feed was successfully added.'
			redirect_to feeds_path
		else
			#flash[:error] == 'Invalid link. Please enter a new one.'
			redirect_to new_feed_path
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