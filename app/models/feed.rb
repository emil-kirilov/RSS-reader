class Feed < ActiveRecord::Base
	validate :url_must_be_valid

	has_many :posts, dependent: :destroy
	validates :url, presence: true, uniqueness: { message: "You already receive news from this RSS feeder" }
	
	def url_must_be_valid
    if ApplicationController.helpers.legit self
      true
    else
      errors.add(:url, "invalid")
    end
  end

  def self.refresh_posts
  	feeds = Feed.all
  	feeds.each do |feed|
  		newest_posts_pud_date = Time.new(1900)
  		if Post.where(feed_id: feed.id).length > 0 
  			newest_posts_pud_date = Post.where(feed_id: feed.id).order('posts.pub_date DESC').first.pub_date
  		end
  		#FeedsHelper#save_newer_posts_than
  		ApplicationController.helpers.save_newer_posts_than feed, newest_posts_pud_date
  	end
  end
end