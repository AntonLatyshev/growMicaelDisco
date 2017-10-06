const anchorLink = () => {
  $('.anchor-btn').on('click', function(e) {
    e.preventDefault();
    $(this).addClass('active').siblings().removeClass('active');

    const id = $(this).attr('href');
    const top = $(id).offset().top;
    $('body,html').animate({
      scrollTop: top
    }, 600);
  });

  if ($(window).innerWidth() > 1180 && $('.delivery__anchor').length) {
    $(window).on('scroll', () => {
      const scrollTop = $(window).scrollTop()
      if (scrollTop >= 277) {
        $('.delivery__anchor').addClass('fixed');
      } else {
        $('.delivery__anchor').removeClass('fixed');
      }
    });
  }
}
export default anchorLink;
