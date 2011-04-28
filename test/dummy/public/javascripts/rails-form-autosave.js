(function($) {
   
  $.fn.autosaveFields = function() {
    var form = $(this);
    var form_id = $(this).attr('autosave_id');
    
    
    
    // Step 1 : load the autosaved data
    
    // Step 2 : once it's done, monitor the fields and periodically send updates
    
    // Bonuses : clear saved fields when form is sent
    
  }

  // Main hook
  // If new forms are dynamically introduced into the DOM the .autosaveFields() 
  // method must be invoked manually on these forms
  $(function() { $('form[autosave]').autosaveFields(); })
  
})(jQuery);

