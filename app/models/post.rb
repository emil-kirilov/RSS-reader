class Post < ActiveRecord::Base
	belongs_to :feed

	validates :feed_id, presence: true
	validates :title, presence: true
	validates :link, presence: true
	validates :pub_date, presence:true 
end