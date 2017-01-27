class Post < ActiveRecord::Base
	belongs_to :feed

	validates :feed_id, presence: true
	validates :title, presence: true
	validates :link, presence: true
	validates :pud_date, presence:true 
end