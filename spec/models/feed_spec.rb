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

  describe "#url_must_be_valid" do
  	it "returns true when valid url is passed" do
  		feed = Feed.new(url: "http://www.ruby-lang.org/en/feeds/news.rss")
  		expect(feed.url_must_be_valid).to eql true
  	end
  	
  	it "returns false when invalid url is passed" do
  		feed = Feed.new(url: "invalid url")
  		expect(feed.url_must_be_valid).to eql ["invalid"]
  	end
  end

  describe "::refresh_posts" do 
  	it "does add new posts if they do not exist in the DB" do
  		#I need to learn how to use factories and set state
  		Feed.all.each {|feed| feed.destroy}
  		feed = Feed.create(url:'http://www.ruby-lang.org/en/feeds/news.rss')
      expect{
        Feed.refresh_posts
      }.to change(Post, :count).by(10)
  	end
  end
end