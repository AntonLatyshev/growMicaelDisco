const poup = () => {
  $('.header__callback').on('click', () => {
    $('.callback').addClass('show');
    $('body').addClass('overflow');
    setTimeout("$('.callback__input').eq(0).focus();", 100);
  });
  $('.callback, .callback__close, .popup-review').on('click', () => {
    $('.callback').removeClass('show');
    $('.popup-review').removeClass('show');
    $('body').removeClass('overflow');
  });




  $('.card__buy-onclick').on('click', () => {
    $('.card-click').addClass('show');
    $('body').addClass('overflow');
    setTimeout("$('.card-click').find('.callback__input').eq(0).focus();", 100);
  });





  $('.card-click, .callback__close, .popup-review').on('click', () => {
    $('.card-click').removeClass('show');
    $('.popup-review').removeClass('show');
    $('body').removeClass('overflow');
  });
  $('.thanks').on('click', () => {
    $('.thanks').removeClass('show');
  });
  $('.basket-btn').on('click', () => {
    $('.wrapper').addClass('active');
    $('.popup-basket').addClass('active');
    $('.overlay').addClass('active');
    $('body').addClass('overflow');
  });
  $('.overlay, .popup-basket__close').on('click', () => {
    $('.wrapper').removeClass('active');
    $('.popup-basket').removeClass('active');
    $('.overlay').removeClass('active');
    $('body').removeClass('overflow');
  });
  $('.callback__textarea').on('focus', function() {
    $(this).animate({
      height: '100px'
    }, 300)
  });
  $('.callback__textarea').on('blur', function() {
    if ($(this).val() == '') {
      $(this).animate({
        height: '45px'
      }, 300)
    } else{
      return false;
    }
  });


  $('.review-edit, .card__review-block').on('click', () => {
    $('.popup-review').addClass('show');
    $('body').addClass('overflow');
    setTimeout("$('.callback__input--review').focus();", 100);
    let valueRates = $('.card__review-container').attr('data-rate');
    $('input[id="popup-' + valueRates + '"]').prop('checked', true);
  });

  // remove before backend
  // $('.callback__submit').on('click', (e) => {
  //   e.preventDefault();
  //   setTimeout("$('.thanks').addClass('show');", 200);
  //   $('.callback').removeClass('show');
  //   setTimeout(function() {
  //     $('.thanks').stop().removeClass('show');
  //     $('body').removeClass('overflow');
  //   }, 2000);
  // });
}
export default poup;
