class Feed < ActiveRecord::Base
	validate :url_must_be_valid

	has_many :posts, dependent: :destroy
	validates :url, presence: true, uniqueness: { message: "You already receive news from this RSS feeder" }
	
	def url_must_be_valid
    unless ApplicationController.helpers.legit self
      errors.add(:url, "invalid")
    end
  end
end