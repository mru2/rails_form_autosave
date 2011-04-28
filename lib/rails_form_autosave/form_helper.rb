module RailsFormAutosave::FormHelper

  class Error < StandardError; end

  def form_for(record_or_name_or_array, *args, &proc)
    # Get the form options
    options = args.extract_options!

    # Add the autosave options
    if options[:autosave]
      options[:html] ||= {}
      options[:html][:autosave] = true
      options[:html][:autosave_id] = form_id(record_or_name_or_array, options)
    end
    
    # Call the standard helper
    super(record_or_name_or_array, *(args << options), &proc)
  end
  
  private
    
  # Generate a unique ID for this form
  def form_id(object, options)
    Digest::SHA1.hexdigest("#{request.path}-#{object.to_s}")
  end
end

ActionView::Base.send(:include, RailsFormAutosave::FormHelper)
