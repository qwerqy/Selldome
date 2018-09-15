// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require activestorage
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

$(document).ready(function(){
  $('#listing_place_type').change(function(){
    let type = $(this).val();
    if (type == 'Apartment') {
      $('#listing_property_type').html(
        "<option value=''>Select your Property Type</option><option value='Apartment'>Apartment</option><option value='Condominium'>Condominium</option><option value='Loft'>Loft</option><option value='Serviced Apartment'>Serviced Apartment</option>"
      )
    else if (type == 'House') {
      $('#listing_property_type').html(
        "<option value=''>Select your Property Type</option><option value='Apartment'>Apartment</option><option value='Condominium'>Condominium</option><option value='Loft'>Loft</option><option value='Serviced Apartment'>Serviced Apartment</option>"
      )
    }
  })
})
