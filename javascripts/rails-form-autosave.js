(function($) {

  $.fn.formId = function() {
    return $(this).attr('autosave_id');
  }
   
  $.fn.loadFields = function() {
    form = $(this)
    
    // Update the values
    $.getJSON('/rails_form_autosave/load/'+$(this).formId(), function(data){
      $.each(data,function(id, value){
        form.find('#'+id).val(value);
      });
    });   
  }

  $.fn.saveFields = function() {
    form = $(this)
    
    // Get the fields values
    var params = {};
    form.find('input:visible').each(function(){
      var input = $(this)
      if (input.attr('id').length > 0) {
        params[input.attr('id')] = input.val();
      }
    });
    
    // Send them to be savec
    $.post('/rails_form_autosave/save/'+form.formId(), $.param({rails_form_autosave:params}));
  }
   
  $.fn.clearFields = function() {
    $.get('/rails_form_autosave/clear/'+$(this).formId());
  } 
   
  $.fn.autosaveFields = function() {
    var form = $(this);
    
    // Load the fields
    form.loadFields();

    // Save the fields when edited
    form.find('input:visible').each(function(){
      input = $(this);
      input.blur(function(){form.saveFields();});
    });
    
    // Clear the fields when the form is submitted
    form.submit(function(){
      form.clearFields();
    });
  }

  // Main hook
  // If new forms are dynamically introduced into the DOM the .autosaveFields() 
  // method must be invoked manually on these forms
  $(function() { $('form[autosave]').autosaveFields(); })
  
})(jQuery);

