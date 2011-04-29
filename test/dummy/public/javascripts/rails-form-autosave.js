(function($) {

  var monitoredFields = 'input:visible, textarea:visible, select:visible';

  $.fn.formId = function() {
    return $(this).attr('autosave_id');
  }
   
  $.fn.loadFields = function() {
    form = $(this)
    
    // Update the values
    $.getJSON('/rails_form_autosave/load/'+$(this).formId(), function(data){
      $.each(data,function(id, value){
        input = form.find('#'+id);
        if (input.is(':checkbox') || input.is(':radio')){
          input.attr('checked',value);
        }
        else{
          input.val(value);
        }
      });
    });   
  }

  $.fn.saveFields = function() {
    form = $(this)
    
    // Get the fields values
    var params = {};
    form.find(monitoredFields).each(function(){
      var input = $(this)
      if (input.attr('id').length > 0) {
        if (input.is(':checkbox') || input.is(':radio')){
          if (input.is(':checked')){
            params[input.attr('id')] = 'checked';      
          }
        }
        else{
          params[input.attr('id')] = input.val();
        }
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
    form.find(monitoredFields).each(function(){
      input = $(this);
      input.blur(function(){form.saveFields();});
      input.click(function(){form.saveFields();});
    });
    
    // Clear the fields when the form is submitted
    form.submit(function(){
      form.clearFields();
    });
  }

  // Main hook
  // If new forms are dynamically introduced into the DOM the .autosaveFields() 
  // method must be invoked manually on these forms
  $(function() {
    $('form[autosave]').each(function(){
      $(this).autosaveFields();
    })
  })
  
})(jQuery);

