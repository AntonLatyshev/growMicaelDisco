const header = () => {
  $('.catalog-btn').on('click', function() {
    $(this).toggleClass('active');
    $('.header-catalog').toggleClass('show');
  });
  $('.header-catalog__content, .catalog-btn, .callback__container, .thanks__container').on('click', (e) => {
    e.stopPropagation();
  });
  $('body, html').on('click', () => {
    $('.catalog-btn').removeClass('active');
    $('.header-catalog').removeClass('show');
  });
  $('.header-catalog__link').on('mouseenter', function(e) {
    $('.header-catalog__link').removeClass('active');
    $(this).addClass('active');
  });

  $('.hamburger').on('click', function() {
    $(this).toggleClass('active');
    $('.menu-mobile').toggleClass('show');
  });
  $('.menu-mobile__icon--search').on('click', () => {
    $('.menu-mobile-window').removeClass('show');
    $('.menu-mobile__search').toggleClass('show');
  });
  $('.menu-mobile__icon--phone').on('click', () => {
    $('.menu-mobile-window').removeClass('show');
    $('.menu-mobile__phone').toggleClass('show');
  });
  $('.menu-mobile__icon--basket').on('click', () => {
    $('.menu-mobile-window').removeClass('show');
    $('.popup-basket ').toggleClass('active');
  });
  $('.menu-mobile__nav').on('click', () => {
    $('.menu-mobile-window').removeClass('show');
  });
  $('.language').on('click', () => {
    $('.language__list').toggleClass('show');
  });
  $('.currency').on('click', () => {
    $('.currency__list').toggleClass('show');
  });
}
export default header;
