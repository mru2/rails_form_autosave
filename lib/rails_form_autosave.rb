module RailsFormAutosave
  class Engine < Rails::Engine
    if Rails.env != "production"
      initializer "static assets" do |app|
        app.middleware.use ::ActionDispatch::Static, "#{root}/public"
      end
    end
  end
end

require 'rails_form_autosave/form_helper'
