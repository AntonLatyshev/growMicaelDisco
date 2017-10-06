const basketPopup = () => {
  $('.product-min').each(function() {
    function summQuantity() {
      var quantity = $('.product-min__quantity');
      $('.popup-basket__heading-value').text('(' + quantity.length + ')');
      var a = 0;
      quantity.each(function() {
        a += parseFloat($(this).text());
      });
      $('.summ-quantity').text(a)
    }
    summQuantity();

    function summBasket() {
      var summarry = $('.product-min__price');
      $('.summ-basket').text('' + summarry + ' + .00');
      var b = 0;
      summarry.each(function() {
        b += parseFloat($(this).text());
      });
      $('.summ-basket').text(b + '.00')
    }
    summBasket();

    function remove() {
      $('.product-min__basket-icon').on('click', function() {
        $(this).closest('.product-min').remove();
        summQuantity();
        summBasket();
      });
    }
    remove();


    var val = parseInt($(this).find('.product-min__value').text());
    var price = $(this).find('.product-min__price').text()
    var RegEx = /\s/g;
    price = parseFloat(price.replace(RegEx, ""));
    var current = price

    var count = 1;


    $(this).on('click', '.product-min__button', function() {
      if ($(this).attr('id') == 'increment') {
        (count += 1)
        $(this).closest('.product-min').find('.product-min__price').text((price += current) + ' грн')
      } else {
        (count -= 1)
        $(this).closest('.product-min').find('.product-min__price').text((price -= current) + ' грн')
      }
      if (count <= 0) {
        count = 1;
      }
      if (price <= current) {
        price = current;
        $(this).closest('.product-min').find('.product-min__price').text(price + ' грн')
      }
      $(this).closest('.product-min').find('.product-min__quantity').text(count + 'X')
      $(this).closest('.product-min').find('.product-min__value').text(count + ' шт.')
      summQuantity();
      summBasket();
    });
  });




}
export default basketPopup;
