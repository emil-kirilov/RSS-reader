require 'rails_helper'
require 'spec_helper'

RSpec.describe FeedsController, :type => :controller do
	describe "GET 	/feeds/new" do
		#first attempt
		it "should render new template" do 
			get 'new'
	  	expect(response).to render_template('new')
		end

	  it "should redirect to index" do 
	  	post 'create', params: { feed: { url: 'http://feeds.reuters.com/reuters/technologyNews' } }
	  	expect(response).to redirect_to(feeds_path)
	  end

	  it "should redirect with a notice on successful save" do 
	  	post 'create', params: { feed: { url: 'http://feeds.reuters.com/reuters/technologyNews' } }
	  	expect(flash[:notice]).not_to be_nil
	  end

	  it "should re-render new template on failed save" do
	  	post 'create', params: { feed: { url: nil } }
	  	expect(flash[:error]).not_to be_nil
	  	expect(response).to render_template('new')
	  end 
	end

	describe "POST 	/feeds" do
		it "should create feed with valid params" do 
  		expect { 
  			post :create, params: { feed: { url: 'http://feeds.reuters.com/reuters/technologyNews'} } 
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
	end

	describe "DELETE 	/feeds/:id" do
		it "should destroy feed" do 
			feed = Feed.new(url: 'http://feeds.reuters.com/reuters/technologyNews')
			feed.save
			expect { 
				feed.destroy 
				}.to change(Feed, :count).by(-1)
		end
			
    #TODO - figure out why this does not work
		#it "should set flash[:notice]" do 
		#	feed = Feed.new(url: 'http://feeds.reuters.com/reuters/technologyNews')
		#	feed.save
		#	feed.destroy
		#	expect(flash[:notice]).not_to be_nil
		#end
	end

	describe "GET 	/feeds/:id/edit" do
		it "should render edit template" do 
			feed = Feed.new(url: 'http://feeds.reuters.com/reuters/technologyNews')
			feed.save
			get :edit, params: { id: 1 }
	  	expect(response).to render_template('edit')
		end
	end

	#TODO - fix this
	describe "PATCH 	/feeds/:id" do 
		it "should save the new values if they are valid" do 
			feed = Feed.new(url: 'http://feeds.reuters.com/reuters/technologyNews')
			feed.save
			url = 'http://feeds.reuters.com/news/artsculture'
			patch :update, params: { id: 1, feed: { url: 'http://feeds.reuters.com/news/artsculture' } }
			expect(feed.url).to eql url 
		end
	end
end
