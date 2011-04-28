module RailsFormAutosave
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../../templates', __FILE__)

      desc 'Creates a RailsFormAutosave initializer and copies rails-form-autosave.js to public/javascripts.'

      def copy_locale
        copy_file '../../../javascripts/rails-form-autosave.js', 'public/javascripts/rails-form-autosave.js'
      end

      def show_readme
        readme 'README' if behavior == :invoke
      end
    end
  end
end
