const filter = () => {
  $('.filter__title').on('click', function() {
    $(this).next().slideToggle();
    $(this).toggleClass('open');
  });


  $('.sort').on('click', function() {
    $(this).addClass('open');
  });
  $('.sort').on('mouseleave', function() {
    $(this).removeClass('open');
  });


  $('.tumb__btn').on('click', function() {
    $('.tumb__btn').removeClass('active');
    $(this).addClass('active');
    if ($(this).attr('id') === 'block') {
      $('.catalog__content').removeClass('catalog__content--list');
    } else {
      $('.catalog__content').addClass('catalog__content--list');
    }
  });


    $('.filter__heading').on('click', () => {
      $('.filter__hidden').addClass('open');
    });

    $('.callback__close').on('click', () => {
      $('.filter__hidden').removeClass('open');
    });
}
export default filter;
