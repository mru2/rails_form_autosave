Rails.application.routes.draw do

  # Get the saved forms
  namespace :rails_form_autosave do
    match 'load/:id' => "rails_form_autosave#load"
    match 'save/:id' => "rails_form_autosave#save", :via => :post
    match 'clear/:id' => "rails_form_autosave#clear"
  end

end