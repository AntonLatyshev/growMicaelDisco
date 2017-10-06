const valuation = () => {
  $('.valuation__event').on('click', function() {
    let value = $(this).find('.valuation__value');
    let current = +value.text();
    if ($(this).hasClass('active')) {
      $(this).removeClass('active');
      value.text(current - 1)
    } else {
      if ($(this).siblings().hasClass('active')) {
        let currentSiblings = $(this).siblings().find('.valuation__value').text()
        $(this).siblings().find('.valuation__value').text(currentSiblings - 1)
      }
      $(this).addClass('active');
      $(this).siblings().removeClass('active');

      value.text(current + 1)
    }
  });
}
export default valuation;
