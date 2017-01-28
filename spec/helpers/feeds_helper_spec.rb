require 'rails_helper'
require 'spec_helper'

describe FeedsHelper do
	describe "#legit" do
    it "returns true when a legit url is passed" do 
      feed = Feed.new(url:'http://www.ruby-lang.org/en/feeds/news.rss')   
      response = legit feed
      expect(response).to be(true)
    end

    it "returns false when nil is passed" do 
      response = legit nil
      expect(response).to be(false)
    end

    it "returns false when an illegitimate url is passed" do 
      feed = Feed.new(url:'test')   
      response = legit feed
      expect(response).to be(false)
    end
  end
end