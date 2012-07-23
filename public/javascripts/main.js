$(document).ready(function(){
  $("select").change(function () {
          window.location.href = "?view_option=" + $('select option:selected').attr('value');
        });
      })