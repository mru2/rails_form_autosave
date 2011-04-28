class RailsFormAutosaveController < ApplicationController
  
  def load
    @id = params[:id]
    render :text => "Loaded form #{@id}"
  end
  
  def save
    @id = params[:id]
    render :text => "Saved form #{@id}"    
  end
  
end