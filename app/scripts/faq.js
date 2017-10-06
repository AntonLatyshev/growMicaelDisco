const faq = () => {
  $('.faq__head').on('click', function() {
    if ($(this).closest('.faq__block').hasClass('open')) {
      $('.faq__block').removeClass('open');
    } else {
      $('.faq__block').removeClass('open');
      $(this).closest('.faq__block').addClass('open');
    }
    $('.faq__section').stop().slideUp(400);
    $(this).next().stop().slideToggle(400);
  });

  $('.faq__open').on('click', function() {
    $(this).closest('.tr').toggleClass('open');
    $(this).closest('.tr').next().slideToggle();
  });
}
export default faq;
