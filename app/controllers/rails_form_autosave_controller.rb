require 'json'

# This controller handles the link between the form fields, and the current session
class RailsFormAutosaveController < ApplicationController
  
  # Parameter : 
  #  - id(GET) : form ID
  # Returns a json of the saved form fields
  def load
    @form_id = params[:id]
    session[:rails_form_autosave] ||= {}
    render :text => session[:rails_form_autosave][@form_id].to_json
  end
  
  # Parameters : 
  #  - id(GET) : form ID
  #  - rails_form_autosave(POST) : hash of the form fields to save (field id => field value)
  # Saves the form fields in the session. Overrides existing fields values
  def save
    @form_id = params[:id]
    @fields = params[:rails_form_autosave]
    # Updates the form fields hash
    @rails_form_autosave_hash = {}
    @rails_form_autosave_hash.merge! session[:rails_form_autosave] if session[:rails_form_autosave]
    @rails_form_autosave_hash.merge!({@form_id => @fields})
    # Saves it in the session
    session[:rails_form_autosave] = @rails_form_autosave_hash
    render :text => "Saved form #{@form_id} : #{@fields.to_json}"
  end
  
  # Parameter : 
  #  - id(GET) : form ID
  # Clears all the form fields in the session
  def clear
    @form_id = params[:id]

    # Clears the form fields hash
    session[:rails_form_autosave] ||= {}
    session[:rails_form_autosave][@form_id] = {}
    
    render :text => "Cleared form #{@form_id} : #{session[:rails_form_autosave][@form_id].to_json}"
  end
  
end