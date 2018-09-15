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
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

$(document).ready(function(){
  $('#listing_place_type').change(function(){
    let type = $(this).val();
    if (type == 'Apartment') {
      $('#listing_property_type').html($('#listing_property_type_apartment').html())
    }
    else if (type == 'House') {
      $('#listing_property_type').html($('#listing_property_type_house').html())
    }
    else if (type == 'Secondary Unit') {
      $('#listing_property_type').html($('#listing_property_type_secondary_unit').html())
    }
    else if (type == 'Unique Space') {
      $('#listing_property_type').html($('#listing_property_type_unique_space').html())
    }
    else if (type == 'Boutique Hotel') {
      $('#listing_property_type').html($('#listing_property_type_boutique_hotel').html())
    }
    else if (type == 'Restaurant') {
      $('#listing_property_type').html($('#listing_property_type_restaurant').html())
    }
    else if (type == 'Cafe') {
      $('#listing_property_type').html($('#listing_property_type_cafe').html())
    }
    else {
      $('#listing_property_type').html($('#listing_property_type_none').html())
    }
  })
})
