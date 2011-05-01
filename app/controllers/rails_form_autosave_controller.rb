require 'json'

class RailsFormAutosaveController < ApplicationController
  
  def load
    @form_id = params[:id]
    session[:rails_form_autosave] ||= {}
    render :text => session[:rails_form_autosave][@form_id].to_json
  end
  
  def save
    @form_id = params[:id]
    @fields = params[:rails_form_autosave]
        
    rails_form_autosave_hash = {}
    rails_form_autosave_hash.merge! session[:rails_form_autosave] if session[:rails_form_autosave]
    rails_form_autosave_hash.merge!({@form_id => @fields})
    
    session[:rails_form_autosave] = rails_form_autosave_hash

    render :text => "Saved form #{@form_id} : #{@fields.to_json}"
  end
  
  def clear
    @form_id = params[:id]
    session[:rails_form_autosave] ||= {}
    session[:rails_form_autosave][@form_id] = {}
    
    render :text => "Cleared form #{@form_id} : #{session[:rails_form_autosave][@form_id].to_json}"
  end
  
end