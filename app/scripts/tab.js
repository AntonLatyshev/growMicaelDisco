const tab = () => {
  $('.tab').each(function() {
      $(this).find('.tab__content').eq(0).css('display', 'block');
      $(this).find('.tab__item').eq(0).addClass('active');
  });
  if ($('.features__catalog').length) {
    $('.features__catalog').zellionTabs({
      animation: 'fade'
    });
  }
  if ($('.tab-catalog').length) {
    $('.tab-catalog').zellionTabs({
      animation: 'slide',
      direction: 'bottom'
    });
  }
  if ($('.card-tab').length) {
    $('.card-tab').zellionTabs({
      animation: 'fade'
    });
  }
}
export default tab;
