$( document ).ready(function() {

  function shuffle(array) {
    var currentIndex = array.length
      , temporaryValue
      , randomIndex
      ;

    // While there remain elements to shuffle...
    while (0 !== currentIndex) {

      // Pick a remaining element...
      randomIndex = Math.floor(Math.random() * currentIndex);
      currentIndex -= 1;

      // And swap it with the current element.
      temporaryValue = array[currentIndex];
      array[currentIndex] = array[randomIndex];
      array[randomIndex] = temporaryValue;
    }

    return array;
  }

  var reviewCards = function(selection) {
    var index = 0;
    var card = selection[index];
    $( '#front' ).append(card.front);
    $( '.card' ).toggleClass( 'hidden' );

    $( '.show-back' ).on( 'click', function() {
      $( '#back' ).append(card.back);
      $( '.show-back' ).toggleClass( 'hidden' );
      $( '.next' ).toggleClass( 'hidden' );
    });

    $( '.next' ).on( 'click', function() {

      if (index < selection.length - 1 ) {
        index += 1;
        card = selection[index]

        $( '.show-back' ).toggleClass( 'hidden' );
        $( '.next' ).toggleClass( 'hidden' );

        document.getElementById( 'back' ).innerHTML = "";
        document.getElementById( 'front' ).innerHTML = card.front;
      } else {
        location.reload();
      }
    });

  };

  var selectCards = function(amount) {
    $( '.form' ).toggleClass( 'hidden' );
    $.get("/cards.json", function(data) {
      var shuffled = shuffle(data);
      var selection = shuffled.slice(0, amount);
      reviewCards(selection);
    });
  };

  var error = function(amount) {
    if ( amount <= 0 ) {

    }
  };

  $( '#begin1' ).on( 'click', function() {
    var amount = parseInt($( ".amount" ).val());
    if( amount && amount > 0 ) {
      selectCards(amount);
    } else {
      error(amount);
    }
  });

  $( '#begin2' ).on( 'click', function() {
    var amount = parseInt($( ".amount" ).val());
    var tags = $( ".tags" ).val();
    if( amount && amount > 0 && tags.length > 0 ) {
      selectCardsFromTags(amount, tags);
    } else {
      alert( "YOU DUN MESSED UP")
    }
  });

});
