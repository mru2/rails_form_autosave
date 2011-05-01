require File.dirname(__FILE__) + '/../spec_helper'

describe "Autosave Test", :js => true do
  
  it "should save the fields value in session" do
    visit new_article_path
    
    fill_in :title, :with => "Title"
    fill_in :body,  :with => "body content"
    fill_in :tags,  :with => "ruby & rails"
    #can't check the session...
    session[:rails_form_autosave].should_not be_nil
  end
  
end

