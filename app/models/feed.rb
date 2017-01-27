class Feed < ActiveRecord::Base
	has_many :posts, :dependent => :destroy

	validates :url, presence: true, uniqueness: { message: "You already receive news from this RSS feeder" }
end