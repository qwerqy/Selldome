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

  $(document).on("turbolinks:load", function() {

    $(".alert" ).fadeOut(3000);

    $('#pending-verification').click(function(){
      event.preventDefault();
      $.ajax({
        url: '/pending-verification',
        success: function(data) {
          $('#panel-box').load('/pending-verification');
        }
      })
    });

    $('#verified-listings').click(function(){
      event.preventDefault();
      $.ajax({
        url: '/verified-listings',
        success: function(data) {
          $('#panel-box').load('/verified-listings');
        }
      })
    });

    $('#view-users').click(function(){
      event.preventDefault();
      $.ajax({
        url: 'all-users',
        success: function(data) {
          $('#panel-box').load('/all-users');
        }
      })
    });

    function populate_property_type(place) {
      $.get('/get_property_from_place_type', {place_type: place}, function(data){
        let $property_type = $('#listing_property_type');
        $property_type.empty();
        for (i = 0; i < data.property_type.length; i++) {
          $property_type.append("<option value='" + data.property_type[i] + "'>" + data.property_type[i] + '</option>');
        }
      }, "json");
    }
    $('#listing_place_type').change(function(){
      let val = $(this).val();
      if (val == 1) {
        populate_property_type(1);
      }
      else if (val == 2) {
        populate_property_type(2);
      }
      else if (val == 3) {
        populate_property_type(3);
      }
      else if (val == 4) {
        populate_property_type(4);
      }
      else if (val == 5) {
        populate_property_type(5);
      }
      else if (val == 6) {
        populate_property_type(6);
      }
      else if (val == 7) {
        populate_property_type(7);
      }
    });


  });
