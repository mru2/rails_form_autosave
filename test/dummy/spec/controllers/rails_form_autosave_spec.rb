require File.dirname(__FILE__) + '/../spec_helper'

describe RailsFormAutosaveController do
  
  describe "Save method" do
    it "should save the proper values in session when previous session is nil" do
      post "save", {"rails_form_autosave" => {"article_tags"=>"ruby & rails, framework", "article_body"=>"pretty good stuff", "article_submit"=>"Create Article", "article_title"=>"Read me!"}, "id" =>"f146466fdf371ccb7d1f217808ca339e367b400a"}
      assigns(:rails_form_autosave_hash).should eq({"f146466fdf371ccb7d1f217808ca339e367b400a"=>{"article_tags"=>"ruby & rails, framework", "article_body"=>"pretty good stuff", "article_submit"=>"Create Article", "article_title"=>"Read me!"}})
    end
  
    it "should save the proper values in session when previous session is not nil"
    
    it "should render proper text"
    
  end
  
  describe "Load method" do
    it "should render the proper json"
  end
  
  describe "Clear method" do
    it "should render the proper text"
  end
  
end