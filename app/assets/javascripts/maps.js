function initialize() {
  var input = document.getElementById('searchTextField');
  var autocomplete = new google.maps.places.Autocomplete(input);
}

$(function() {
  $('#start-new-game').on('click', function(e){
    e.preventDefault();
    var url = $('#start-new-game a').attr('href');
    request = $.ajax({type: 'GET', url: url,})
    request.done(function (response){
      $('#top-box').hide();
      $('.games').hide();
      $('.ajax-hide').remove();
      $('#start-new-game').hide();
      $('#new-game-form').after(response);
    })
  })
});
