// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require easy_flip

$(function(){ $(document).foundation();

  $(window).load(function(){
    setTimeout(function(){ $('.alert-box').fadeOut() }, 2000);
    $(".header-text").delay(1000).animate({ opacity: 1 }, 700);
    setTimeout(function(){ $(".header-log-in").delay(1000).animate({ opacity: 1 }, 700) }, 1000);
  });

});
