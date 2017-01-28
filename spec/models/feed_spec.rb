require 'rails_helper'

RSpec.describe Feed, :type => :model do
  it "is valid with valid attributes" do
  	feed = Feed.new(url: 'http://www.ruby-lang.org/en/feeds/news.rss')
  	expect(feed).to be_valid
  end
  
  it "is not valid without a url" do
  	feed = Feed.new(url: nil)
  	expect(feed).not_to be_valid
  end

  it "is not valid with invalid url" do
  	feed = Feed.new(url: 'test')
  	expect(feed).not_to be_valid
  end
end