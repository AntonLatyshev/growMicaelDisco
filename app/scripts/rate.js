const rate = () => {
  $('.card__raiting-block').each(function() {
    let valueStar = $(this).find('.card__raiting-val').text();
    $(this).find('[data-star="' + valueStar + '"]').css({
        display: 'block'
    });
  });
  $('.card__head .card__review-block').on('mouseenter', function() {
    let valueMouseenter = $(this).attr('for');
    $('.card__review-container').attr('data-rate', '' + valueMouseenter + '')
  });
  $('.callback__form .card__review-block').on('click', function() {
    let valueMouseenter = $(this).attr('for');
    $('.card__review-container').attr('data-rate', '' + valueMouseenter + '')
  });
}
export default rate;
