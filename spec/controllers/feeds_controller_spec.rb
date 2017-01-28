require 'rails_helper'
require 'spec_helper'

RSpec.describe FeedsController, :type => :controller do
	describe "#new" do
		#first attempt
		it "GET new should render new template" do 
			get 'new'
	  	expect(response).to render_template('new')
		end

	  it "should redirect to index with a notice on successful save" do 
	  	post 'create', params: { feed: { url: 'http://feeds.reuters.com/reuters/technologyNews' } }
	  	expect(flash[:notice]).not_to be_nil
	  	expect(response).to redirect_to(feeds_path)
	  end

	  it "should re-render new template on failed save" do
	  	post 'create', params: { feed: { url: nil } }
	  	expect(flash[:error]).not_to be_nil
	  	expect(response).to render_template('new')
	  end 
	end

	describe "#create" do
		it "should create feed with valid params" do 
  		expect { post :create, params: { feed: { url: 'http://feeds.reuters.com/reuters/technologyNews'} } }.to change(Feed, :count).by(1) 
		end

		it "should not create feed with invalid params" do 
			expect { post :create, params: {feed: {url: 'invalid url'} } }.to change(Feed, :count).by(0) 
		end

		it "should not create feed with nil params" do 
			expect { post :create, params: {feed: {url: nil} } }.to change(Feed, :count).by(0) 
		end

	end
end
