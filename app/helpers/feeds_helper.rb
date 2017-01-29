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
			  	post = feed.posts.create(feed_id: feed.id, title: item.title, link: item.link, pub_date: item.pubDate)
					post.save
				end
			flash[:notice] << " #{rss_data.items.length} new posts added."
			end
		rescue 
		 	flash[:error] = "An error occured while parsing the RSS feeder!"
		end
	end

	def destroy_related_posts(feed) 
		posts = Post.where(feed_id: feed.id)
    posts.each { |post| post.destroy}
	end
end