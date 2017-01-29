require 'rails_helper'
require 'spec_helper'

describe FeedsHelper do
	describe "#legit" do
    it "returns true when a legit url is passed" do 
      feed = Feed.new(url:'http://www.ruby-lang.org/en/feeds/news.rss')   
      expect(legit feed).to be(true)
    end

    it "returns false when nil is passed" do 
      expect(legit nil).to be(false)
    end

    it "returns false when an illegitimate url is passed" do 
      feed = Feed.new(url:'test')   
      expect(legit feed).to be(false)
    end
  end

  describe "#save_posts" do 
    it "should create and save posts from the given feed" do 
      feed = Feed.new(url: 'http://www.ruby-lang.org/en/feeds/news.rss')
      feed.save
      expect{
        save_posts feed
        }.to change(Post, :count).by(10)
    end

    it "should set flash[:notice] on success" do
      feed = Feed.new(url: 'http://www.ruby-lang.org/en/feeds/news.rss')
      feed.save
      #save_posts uses << to add content to flash[:notice], so I need to initialize it 
      flash[:notice] = ""
      save_posts feed
      expect(flash[:notice].size).not_to eq 0
    end

    it "should set flash[:error] on failure" do
      feed = Feed.new(url: 'invalid url')
      feed.save
      save_posts feed
      expect(flash[:error]).not_to be_nil
    end 
  end

  describe "#destroy_related_posts" do
    it "should destroy the posts related to the given feed" do
      feed = Feed.new(url: 'http://www.ruby-lang.org/en/feeds/news.rss')
      feed.save
      post = Post.new(feed_id: feed.id, title: 'title', link: 'link', pub_date: Time.now)
      post.save
      expect{
        destroy_related_posts feed
        }.to change(Post, :count).by(-1)
    end
  end

  describe "#save_newer_posts_than" do
    it "saves post that are new and do not exist in the DB" do
      feed = Feed.create(url:'http://www.ruby-lang.org/en/feeds/news.rss')
      save_posts feed
      posts = Post.where(feed_id: feed.id).order('posts.pub_date DESC').first(2)
      posts[0].destroy
      expect{
        save_newer_posts_than(feed, posts[1].pub_date)
      }.to change(Post, :count).by(1)
    end
  end
end