//= require jquery
//= require jquery_ujs
//= require foundation

$( document ).ready(function() {

  $( '#answer' ).on( 'click', function() {
    console.log('working!');
    $( '#back' ).toggleClass( 'hidden' );
    $( '#front' ).toggleClass( 'hidden' );
  });

});
