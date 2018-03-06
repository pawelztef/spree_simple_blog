// Placeholder manifest file.
// the installer will append this file to the app vendored assets here: vendor/assets/javascripts/spree/backend/all.js'
$(document).ready(function() {
  set_chbx($('#blog_entry_project'));

  $('#mobility_locale').on('change', function() { 
    $('#mobility_form').submit();
  });

  $('#blog_entry_project').on('change', function() {
    var chbx = $(this);
    set_chbx(chbx);
  });

  var file_input = $('#blog_entry_blog_entry_image_attributes_attachment');
  var label = $('label[for="blog_entry_blog_entry_image_attributes_attachment"]');

  file_input.on('change', function(e) {
    e.preventDefault();
    label.html('<i class="glyphicon glyphicon-save"></i>' + file_input.val().split('\\').pop());
  });

  $('.chosen-select').chosen({
    placeholder_text_multiple: ' '
  });

});

function set_chbx(chbx) {
  var categories = $('.blog-entry-categories');
  if(chbx.is(':checked')){
    categories.hide();
  } else {
    categories.show();
  }
}
