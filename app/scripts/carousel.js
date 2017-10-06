const carousel = (node) => {
  $('.main-carousel').slick({
    infinite: true,
    slidesToShow: 1,
    slidesToScroll: 1,
    vertical: true,
    verticalSwiping: true,
    responsive: [{
      breakpoint: 1180,
      settings: {
        vertical: false,
        verticalSwiping: false
      }
    }]
  });
  $('.features .tab__content').slick({
    infinite: true,
    slidesToShow: 4,
    slidesToScroll: 1,
    variableWidth: true,
    responsive: [{
        breakpoint: 920,
        settings: {
          slidesToShow: 2
        }
      },
      {
        breakpoint: 480,
        settings: {
          slidesToShow: 1,
          variableWidth: false
        }
      }
    ]
  });
  $('.brands__carousel').slick({
    slidesToShow: 8,
    slidesToScroll: 1,
    responsive: [{
        breakpoint: 920,
        settings: {
          slidesToShow: 4
        }
      },
      {
        breakpoint: 480,
        settings: {
          slidesToShow: 2,
          variableWidth: false
        }
      }
    ]
  });
  const $slickElement = $('.article__carousel');
  const $status = $('.article__current');
  $slickElement.on('init reInit afterChange', function(event, slick, currentSlide, nextSlide) {
    let i = (currentSlide ? currentSlide : 0) + 1;
    if (i < 10) {
      $status.html('<span class="current-first">' + i + '</span>/<span>' + slick.slideCount + '</span>');
    } else {
      $status.html('<span class="current-first">' + i + '</span>/<span>' + slick.slideCount + '</span>');
    }
  });
  $('.article__carousel').slick({
    slidesToShow: 1,
    slidesToScroll: 1,
    fade: true
  });

  $('.carousel-nav__container').slick({
    slidesToShow: 10,
    slidesToScroll: 1,
    arrows: false,
    focusOnSelect: true,
    asNavFor: '.carousel-for',
    responsive: [{
      breakpoint: 480,
      settings: {
        slidesToShow: 4
      }
    }]
  });
  $('.carousel-for').slick({
    slidesToShow: 1,
    slidesToScroll: 1,
    fade: true,
    arrows: false,
    asNavFor: '.carousel-nav__container'
  });
  $('.command-carousel').slick({
    centerMode: true,
    focusOnSelect: true,
    // variableWidth: true,
    centerPadding: '0px',
    speed: 600,
    slidesToShow: 9,
    responsive: [{
          breakpoint: 1300,
          settings: {
            slidesToShow: 7
          }
        },
        {
        breakpoint: 1180,
        settings: {
          slidesToShow: 5
        }
      },
      {
        breakpoint: 481,
        settings: {
          slidesToShow: 1,
          centerMode: false,
          variableWidth: false
        }
      }
    ]
  });
  $('.card-carousel-nav').slick({
    slidesToShow: 4,
    slidesToScroll: 1,
    focusOnSelect: true,
    asNavFor: '.card-carousel-for',
    vertical: true,
    initialSlide: 2,
    verticalSwiping: true,
    infinite: false
  });
  $('.card-carousel-for').slick({
    slidesToShow: 1,
    slidesToScroll: 1,
    vertical: true,
    verticalSwiping: true,
    infinite: false,
    arrows: false,
    asNavFor: '.card-carousel-nav',
    responsive: [{
        breakpoint: 765,
        settings: {
          slidesToShow: 1,
          slidesToScroll: 1,
          vertical: false,
          verticalSwiping: false,
          arrows: true
        }
      }
    ]
  });
}
export default carousel;
