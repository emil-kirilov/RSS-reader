require 'rails_helper'
require 'spec_helper'

RSpec.describe FeedsController, :type => :controller do
	describe "GET /feeds/new" do
		#first attempt
		it "should render new template" do 
			get :new
	  	expect(response).to render_template('new')
		end
	end

	describe "POST /feeds" do
		it "should create feed with valid params" do 
  		expect { 
  			post :create, params: { feed: { url: 'http://feeds.reuters.com/reuters/USVideoTechnology'} } 
  			}.to change(Feed, :count).by(1) 
		end

		it "should not create feed with invalid params" do 
			expect { 
				post :create, params: {feed: {url: 'invalid url'} } 
				}.to change(Feed, :count).by(0) 
		end

		it "should not create feed with nil params" do 
			expect {
			 post :create, params: {feed: {url: nil} } 
			 }.to change(Feed, :count).by(0) 
		end

	  it "should redirect to index" do  
	  	post :create, params: { feed: { url: 'http://feeds.reuters.com/reuters/USVideoTechnology' } }
	  	expect(response).to redirect_to(feeds_path)
	  end

	  it "should redirect with a notice on success" do
	  	post :create, params: { feed: { url: 'http://feeds.reuters.com/reuters/USVideoTechnology' } }
	  	expect(flash[:notice]).not_to be_nil
	  end

	  it "should re-render new template on failure" do
	  	post :create, params: { feed: { url: nil } }
	  	expect(response).to render_template('new')
	  end 
	end

	describe "DELETE /feeds/:id" do
		it "should destroy feed" do 
			feed = Feed.new(id: 1, url: 'http://feeds.reuters.com/reuters/technologyNews')
			feed.save
			expect { 
				delete :destroy, params: {id: feed.id}
				}.to change(Feed, :count).by(-1)
		end

		it "should destroy related posts" do 
			feed = Feed.new(id: 1, url: 'http://feeds.reuters.com/reuters/technologyNews')
			feed.save
			post = Post.new(feed_id: feed.id, title: 'title', link: 'link', pub_date: Time.now)
			post.save
			expect { 
				delete :destroy, params: { id: 1 }
				}.to change(Post, :count).by(-1)
		end
			
    #TODO - figure out why this does not work
		it "should set flash[:notice]" do 
			feed = Feed.new(url: 'http://feeds.reuters.com/reuters/technologyNews')
			feed.save
			delete :destroy, params: {id: 1}
			expect(flash[:notice]).not_to be_nil
		end
	end

	describe "GET /feeds/:id/edit" do
		it "should render edit template" do 
			feed = Feed.new(url: 'http://feeds.reuters.com/reuters/technologyNews')
			feed.save
			get :edit, params: { id: 1 }
	  	expect(response).to render_template('edit')
		end
	end

	describe "PATCH /feeds/:id" do 
		it "should save the new values if they are valid" do 
			feed = Feed.new(id:1, url: 'http://feeds.reuters.com/reuters/technologyNews')
			feed.save
			url = 'http://feeds.reuters.com/news/artsculture'
			patch :update, params: { id: feed.id, feed: { url: url  } }
			feed.reload
			expect(feed.url).to eql url 
		end

		it "should not save the new value if they are invalid" do 
			feed = Feed.new(id:1, url: 'http://feeds.reuters.com/reuters/technologyNews')
			feed.save
			url = 'invalid url'
			patch :update, params: { id: feed.id, feed: { url: url  } }
			feed.reload
			expect(feed.url).not_to eql url
		end
	
		it "should set flash[:notice] on succes" do 
			feed = Feed.new(id:1, url: 'http://feeds.reuters.com/reuters/technologyNews')
			feed.save
			url = 'http://feeds.reuters.com/news/artsculture'
			patch :update, params: { id: feed.id, feed: { url: url  } }
			feed.reload
			expect(flash[:notice]).not_to be_nil 
		end

		it "should set flash[:error] on failure" do 
			feed = Feed.new(id:1, url: 'http://feeds.reuters.com/reuters/technologyNews')
			feed.save
			url = 'invalid url'
			patch :update, params: { id: feed.id, feed: { url: url  } }
			feed.reload
			expect(flash[:error]).not_to be_nil
		end

		it "should redirect to the index page on succes" do
			feed = Feed.new(id:1, url: 'http://feeds.reuters.com/reuters/technologyNews')
			feed.save
			url = 'http://feeds.reuters.com/news/artsculture'
			patch :update, params: { id: feed.id, feed: { url: url  } }
			feed.reload
			expect(response).to redirect_to(feeds_path)
		end

		it "should redirect_to the edit page on failure " do
			feed = Feed.new(id:1, url: 'http://feeds.reuters.com/reuters/technologyNews')
			feed.save
			url = 'invalid url'
			patch :update, params: { id: feed.id, feed: { url: url  } }
			feed.reload
			expect(response).to redirect_to(edit_feed_path feed)
		end
	end

	describe "GET /feeds" do 
		it "should render index template" do
			get :index
	  	expect(response).to render_template('index')
		end

		it "should list all feeds" do 
			Feed.create(url: 'http://feeds.reuters.com/reuters/technologyNews')
    	Feed.create(url: 'http://feeds.reuters.com/reuters/USVideoTechnology')
    	get :index
    	expect(assigns[:feeds].size).to eq 2
		end
	end
end
