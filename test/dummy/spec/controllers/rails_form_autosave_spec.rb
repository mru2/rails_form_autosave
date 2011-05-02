require File.dirname(__FILE__) + '/../spec_helper'

describe RailsFormAutosaveController do
  
  describe "check routes" do  
    it "save route" do
      assert_recognizes({:controller => 'rails_form_autosave', :action => 'save', :id => '1'}, {:path => "/rails_form_autosave/save/1", :method => :post}) 
    end
    
    it "load route" do
      assert_recognizes({:controller => 'rails_form_autosave', :action => 'load_form', :id => '1'}, { :path => "rails_form_autosave/load/1"}) 
    end
    
    it "clear route" do
      assert_recognizes({:controller => 'rails_form_autosave', :action => 'clear', :id => '1'}, {:path => "rails_form_autosave/clear/1"}) 
    end
  end
  
  describe "Save method" do
    it "should save the proper values in session when previous session is nil" do
      post "save", {"rails_form_autosave" => {"article_tags"=>"ruby & rails, framework", "article_body"=>"pretty good stuff", "article_submit"=>"Create Article", "article_title"=>"Read me!"}, "id" =>"f146466fdf371ccb7d1f217808ca339e367b400a"}
      session[:rails_form_autosave].should eq({"f146466fdf371ccb7d1f217808ca339e367b400a"=>{"article_tags"=>"ruby & rails, framework", "article_body"=>"pretty good stuff", "article_submit"=>"Create Article", "article_title"=>"Read me!"}})
    end
  
    it "should save the proper values in session when previous session is not nil" do
      session[:rails_form_autosave] = {"007" => {"field1" => "ok"} }
      post "save", {"rails_form_autosave" => {"article_tags"=>"ruby & rails, framework", "article_body"=>"pretty good stuff", "article_submit"=>"Create Article", "article_title"=>"Read me!"}, "id" =>"f146466fdf371ccb7d1f217808ca339e367b400a"}
      possible_values = [{"007"=>{"field1"=>"ok"}, "f146466fdf371ccb7d1f217808ca339e367b400a"=>{"article_tags"=>"ruby & rails, framework", "article_body"=>"pretty good stuff", "article_submit"=>"Create Article", "article_title"=>"Read me!"}}, {"f146466fdf371ccb7d1f217808ca339e367b400a"=>{"article_tags"=>"ruby & rails, framework", "article_body"=>"pretty good stuff", "article_submit"=>"Create Article", "article_title"=>"Read me!"}, "007"=>{"field1"=>"ok"}}]
      possible_values.should include session[:rails_form_autosave]
    end
    
    it "should render proper text" do
      post "save", {"rails_form_autosave" => {"article_body"=>"pretty good stuff"}, "id" =>"f146466fdf371ccb7d1f217808ca339e367b400a"}
      response.body.should == "Saved form f146466fdf371ccb7d1f217808ca339e367b400a : {\"article_body\":\"pretty good stuff\"}"
    end
  end
  
  describe "Load method" do
    it "should render the proper json" do
      session[:rails_form_autosave] = { "1" =>"ok"}
      get "load_form", :id => '1'
      response.body.should == "\"ok\""
    end
  end
  
  describe "Clear method" do
    it "should render the proper text" do
      session[:rails_form_autosave] = { "1" =>"ok"}
      get "clear", :id => '1'
      session[:rails_form_autosave]["1"].should eq({})
      response.body.should == "Cleared form 1 : {}"
    end
  end
  
end