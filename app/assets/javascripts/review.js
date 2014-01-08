$( document ).ready(function() {

  var review = function() {
    $( '.form' ).toggleClass( 'hidden' );
  };

  var error = function() {
    alert( "Much fail. So bad. Wow." );
  };

  $( '.begin' ).on( 'click', function() {
    var amount = parseInt($( ".amount" ).val());
    if( amount ) {
      review();
    } else {
      error();
    }
  });



});
