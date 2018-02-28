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

});

function set_chbx(chbx) {
  var categories = $('#blog_entry_category_list_field');
  var tags = $('#blog_entry_tag_list_field');
  if(chbx.is(':checked')){
    tags.hide();
    categories.hide();
  } else {
    tags.show();
    categories.show();
  }
}
