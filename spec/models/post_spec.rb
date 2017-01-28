require 'rails_helper'
require 'spec_helper'

RSpec.describe Post, :type => :model do
  it "is valid with valid attributes" do
    feed = Feed.new(id: 0, url: 'http://www.ruby-lang.org/en/feeds/news.rss')
    feed.save
    post = Post.new(feed_id: 0, title: 'Title', link: 'link', pub_date: Time.now)
  	expect(post).to be_valid
  end
  
  it "is not valid without a feed_id" do
    post = Post.new(feed_id: nil, title: 'Title', link: 'link', pub_date: Time.now)
    expect(post).not_to be_valid
  end

  it "is not valid without a title " do
    feed = Feed.new(id: 7, url: 'http://www.ruby-lang.org/en/feeds/news.rss')
    feed.save
    post = Post.new(feed_id: 7, title: nil, link: 'link', pub_date: Time.now)
    expect(post).not_to be_valid
  end

  it "is not valid without a link " do
    feed = Feed.new(id: 7, url: 'http://www.ruby-lang.org/en/feeds/news.rss')
    feed.save
    post = Post.new(feed_id: 7, title: 'Title', link: nil, pub_date: Time.now)
    expect(post).not_to be_valid
  end

  it "is not valid without a pub_date " do
    feed = Feed.new(id: 7, url: 'http://www.ruby-lang.org/en/feeds/news.rss')
    feed.save
    post = Post.new(feed_id: 7, title: 'Title', link: 'link', pub_date: nil)
    expect(post).not_to be_valid
  end
end