require 'rails_helper'
require 'spec_helper'

RSpec.describe PostsController, :type => :controller do
	describe "GET /feeds" do
		it "should render index" do 
			get :index
			expect(response).to render_template('index')
		end

		it "should list all posts" do
			Feed.create(url: 'http://feeds.reuters.com/reuters/technologyNews')  	
			Post.create(feed_id: 1, title: 'title', link: 'link', pub_date: Time.now)
			Post.create(feed_id: 1, title: 'title', link: 'link', pub_date: Time.now)

    	get :index
    	expect(assigns[:posts].size).to eq 2
		end
	end

	describe "GET /reader" do 
		it "should redirect to ordered_index" do 
			get :ordered_index
			expect(response).to render_template('ordered_index')
		end

		it "should show all posts ordered by pub_date " do 
			feed = Feed.create(url: 'http://feeds.reuters.com/reuters/technologyNews') 
    	Post.all.order('posts.pub_date ASC')
    	get :ordered_index
    	expect(assigns[:posts]).to eq assigns[:posts].order('posts.pub_date DESC') 
		end
	end

	describe "DELETE /posts/:id" do
		it "should destroy post" do 
			post = Post.new(feed_id: 1, title: 'title', link: 'link', pub_date: Time.now)
			post.save
			expect { 
				delete :destroy, params: { id: post.id}
				}.to change(Post, :count).by(-1)
		end

		it "should set flash[:notice]" do
			post = Post.new(id: 1, feed_id: 1, title: 'title', link: 'link', pub_date: Time.now)
			post.save
			delete :destroy, params: {id: 1}
			expect(flash[:notice]).not_to be_nil
		end
	end
end