require 'rails_helper'
require 'spec_helper'

RSpec.describe FeedsController, :type => :controller do
	it "GET new should render new template" do 
		get 'new'
  	expect(response).to render_template('new')
	end

  it "should redirect to index with a notice on successful save" do 
  	post 'create', params: { feed: { url: "test" } }
  	expect(flash.notice).not_to be_nil
  	expect(response).to redirect_to(feeds_path)
  end

  it "should re-render new template on failed save" do
  	post 'create', params: { feed: { url: nil } }
  	expect(flash.error).not_to be_nil
  	expect(response).to render_template('new')
  end 
end
