require 'rss'
require 'open-uri'

module FeedsHelper
	#different errors are thrown when the url cannot be opened or parsed 
	def legit(feed)
		begin 
			open(feed.url) { |rss| 
				feed = RSS::Parser.parse(rss)
			}
			true
		rescue
		 	false
		end
	end

	def save_posts(feed)
		begin 
			open(feed.url) do |rss|
		  	rss_data = RSS::Parser.parse(rss)
		 	 	rss_data.items.each do |item|
			 	 	title = item.title
			  	link = item.link
			  	pub_date = item.pubDate

			  	post = Post.new(feed_id: feed.id, title: title, link: link, pub_date: pub_date)
					post.save
				end
			end
			flash[:notice] << "New posts added."
		rescue 
		 	flash[:error] = "An error occured while parsing the RSS feeder!"
		end
	end

	def destroy_child_posts feed 
		posts = Post.where(feed_id: feed.id)
    posts.each { |post| post.destroy}
	end
end