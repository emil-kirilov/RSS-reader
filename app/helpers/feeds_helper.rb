require 'rss'
require 'open-uri'

module FeedsHelper
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
end