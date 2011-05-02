module RailsFormAutosave::FormHelper

  class Error < StandardError; end


  # Extend the form_for helper, to handle the :autosave option
  def form_for(record_or_name_or_array, *args, &proc)
    # Get the form options
    options = args.extract_options!

    # Add the autosave options
    if options[:autosave]
      options[:html] ||= {}
      options[:html][:autosave] = true
      options[:html][:autosave_id] = form_id(record_or_name_or_array, options)
    end
    
    # Call the standard helper with the added options
    super(record_or_name_or_array, *(args << options), &proc)
  end
  
  private
    
  # Generate a unique ID for a form (based on the page url, and the form name)
  def form_id(object, options)
    # Get the name of the form
    form_name = case object
    when String, Symbol
      object
    else
      options[:as] || ActiveModel::Naming.singular(object)
    end
    
    # Generate a unique ID
    Digest::SHA1.hexdigest("#{request.path}-#{form_name}")
  end
end

ActionView::Base.send(:include, RailsFormAutosave::FormHelper)
