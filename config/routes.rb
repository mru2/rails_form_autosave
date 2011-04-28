Rails.application.routes.draw do

  # Get the saved forms
  match '/rails_form_autosave/load/:id' => "rails_form_autosave#load"
  match '/rails_form_autosave/save/:id' => "rails_form_autosave#save"
end