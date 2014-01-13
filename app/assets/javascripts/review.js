//= require jquery
//= require jquery_ujs
//= require foundation

$( document ).ready(function() {

  $( '#answer' ).on( 'click', function() {
    $( '#back' ).toggleClass( 'hidden' );
    $( '#front' ).toggleClass( 'hidden' );
  });

});
