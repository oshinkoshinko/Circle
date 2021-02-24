/*global $*/
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
//= require jquery
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

//マイページ新規投稿モーダルウインドウ
document.addEventListener("turbolinks:load", function() {
  $("#show_action").on("click", function() {
    $("div.modal").addClass("is-active");
    })

  $('div.modal-background,button.modal-close').on('click', function() {
    $("div.modal").removeClass("is-active");
  })
})

//イベント一覧ページslick用
document.addEventListener("turbolinks:load", function() {
  $(function() {
    $('#new-card').slick({
      autoplay: true,
      slidesToShow: 4,
      adaptiveHeight: true,
      autoplaySpeed: 1500,
      arrows: true,
      dots: true,
      responsive: [
       {
        breakpoint: 1024,
        settings: {
        slidesToShow: 3,
        slidesToScroll: 3,
        infinite: true,
          dots: true
         }
        },
        {
        breakpoint: 600,
        settings: {
        slidesToShow: 2,
        slidesToScroll: 2
         }
        },
        {
        breakpoint: 480,
        settings: {
        slidesToShow: 1,
        slidesToScroll: 1,
        dots: false
        }
      }]
    });
  });
})

document.addEventListener("turbolinks:load", function() {
  $(function() {
    $('#finished-card').slick({
      autoplay: true,
      slidesToShow: 4,
      adaptiveHeight: true,
      autoplaySpeed: 1500,
      arrows: true,
      dots: true,
      responsive: [
       {
        breakpoint: 1024,
        settings: {
        slidesToShow: 3,
        slidesToScroll: 3,
        infinite: true,
          dots: true
         }
        },
        {
        breakpoint: 600,
        settings: {
        slidesToShow: 2,
        slidesToScroll: 2
         }
        },
        {
        breakpoint: 480,
        settings: {
        slidesToShow: 1,
        slidesToScroll: 1,
        dots: false
        }
      }]
    });
  });
})

document.addEventListener("turbolinks:load", function() {
  $(function() {
    $('#feedback-card').slick({
      autoplay: true,
      slidesToShow: 4,
      adaptiveHeight: true,
      autoplaySpeed: 1500,
      arrows: true,
      dots: true,
      responsive: [
       {
        breakpoint: 1024,
        settings: {
        slidesToShow: 3,
        slidesToScroll: 3,
        infinite: true,
          dots: true
         }
        },
        {
        breakpoint: 600,
        settings: {
        slidesToShow: 2,
        slidesToScroll: 2
         }
        },
        {
        breakpoint: 480,
        settings: {
        slidesToShow: 1,
        slidesToScroll: 1
        }
      }]
    });
  });
})

//ブラウザ戻るボタン無効化
document.addEventListener("turbolinks:load", function() {
  history.pushState(null, null, null);
    $(window).on("popstate", function (event) {
      if (!event.originalEvent.state) {
      history.pushState(null, null, null);
      return;
    }
  });
})

//投稿一覧ページアンカースクロール
document.addEventListener("turbolinks:load", function() {
  $(function () {
    $('a[href^="#"]').click(function () {
        var speed = 500;
        var href= $(this).attr("href");
        var target = $(href == "#" || href == "" ? 'html' : href);
        var position = target.offset().top;
        $("html, body").animate({scrollTop:position}, speed, 'swing');
        return false;
    });
  });
})