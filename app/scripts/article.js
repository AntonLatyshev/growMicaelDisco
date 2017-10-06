const article = () => {
  if ($(window).innerWidth() > 1180 && ($('.article__prev').length || $('.article__next').length)) {

    const scrollOffsetPrev = $('.article__prev').offset().left
    $(window).on('scroll', () => {
      const scrollTop = $(window).scrollTop()
      if (scrollTop >= 277) {
        $('.article__prev').addClass('fixed');
        $('.article__prev').css({
          left: scrollOffsetPrev
        })
      } else {
        $('.article__prev').removeClass('fixed');
        $('.article__prev').css({
          left: 0
        })
      }
    });
    const scrollOffsetNext = $('.article__next').offset().left
    $(window).on('scroll', () => {
      const scrollTop = $(window).scrollTop()
      if (scrollTop >= 277) {
        $('.article__next').addClass('fixed');
        $('.article__next').css({
          left: scrollOffsetNext
        })
      } else {
        $('.article__next').removeClass('fixed');
        $('.article__next').css({
          left: 'auto',
          rigth: 0
        })
      }
    });
  }
}
export default article;
