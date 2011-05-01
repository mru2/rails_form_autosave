(function($) {

  // The dom selectors of the fields being monitored
  var monitoredFields = 'input:visible, textarea:visible, select:visible';

  // Get the ID of an autosave form
  $.fn.formId = function() {
    return $(this).attr('autosave_id');
  }
   
  // Load the saved fields of a form
  $.fn.loadFields = function() {
    var form = $(this)
    
    // Get the values
    $.getJSON('/rails_form_autosave/load/'+$(this).formId(), function(data){
      $.each(data,function(id, value){
        // For each value, find the input with the corresponding ID
        input = form.find('#'+id);
        
        // If the input is a checkbox or a radio button, we have to use a different way to set it's value
        if (input.is(':checkbox') || input.is(':radio')){
          input.attr('checked',value);
        }
        // Otherwise, just replace the existing value with the one we just got
        else{
          input.val(value);
        }
      });
    });   
  }

  // Save the fields of a form in the session
  $.fn.saveFields = function() {
    var form = $(this)
    
    // We are creating a hash of field ID - field value pairs
    var params = {};
    
    // We iterate on the fields
    form.find(monitoredFields).each(function(){
      var input = $(this)
      
      // Only the fields with an ID are being saved
      if (input.attr('id').length > 0) {

        // Once again, specific case for the checkboxes / radio buttons
        if (input.is(':checkbox') || input.is(':radio')){
          if (input.is(':checked')){
            params[input.attr('id')] = 'checked';      
          }
        }
        // Adding the field ID - field value pair to the hash
        else{
          params[input.attr('id')] = input.val();
        }
      }
    });
    
    // Tweak to be able to update a rails session with a post request
    $.ajaxSetup({
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
      }
    });

    // Now send the hash via AJAX to save the values
    $.post('/rails_form_autosave/save/'+form.formId(), $.param({rails_form_autosave:params}));
  }
   
  // Clear the saved fields of a form (in the rails session)
  $.fn.clearFields = function() {
    $.get('/rails_form_autosave/clear/'+$(this).formId());
  } 
   
  // Load the saved fields of a form, then monitor them to automatically save them
  $.fn.autosaveFields = function() {
    var form = $(this);
    
    // Load the field values
    form.loadFields();

    // Add callbacks on the fields
    form.find(monitoredFields).each(function(){
      input = $(this);

      // The form will be saved when the user clicks on and off a field
      input.blur(function(){form.saveFields();});
      input.click(function(){form.saveFields();});
    });
    
    // When the form is submitted, clear the field values from the session
    form.submit(function(){
      form.clearFields();
    });
  }

  // Main hook : call the autosaveFields() on every form having the autosave attribute
  // If new forms are dynamically introduced into the DOM the .autosaveFields() 
  // method must be invoked manually on these forms
  $(function() {
    $('form[autosave]').each(function(){
      $(this).autosaveFields();
    })
  })
  
})(jQuery);

