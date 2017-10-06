$(document).ready(function(){
  $(document).on('click', '.form-tab-nav li', function (e) {
    e.preventDefault();
    $('.form-tab-nav li').removeClass('active');
    $(this).addClass('active');
    var tab = $(this).find('a').attr('href');
    setTab(tab);
    // set value
    $('input[name="customer"]').prop('value', $(this).data('customer'));

    $.ajax({
      url: '/index.php?route=checkout/step_first/customer',
      type: 'post',
      data: {'customer': $('input[name="customer"]').prop('value')},
      dataType: 'html',
      success: function(html) {
        $('#step-1').html(html);
      },
      error: function(xhr, ajaxOptions, thrownError) {
        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      }
    });

  });

  $(document).on('click', '.handler-work-time', function (e) {
    var workTimePopup = document.querySelector('.cart-work-time__popup');
    workTimePopup.classList.toggle('active');
  });
  
  // коментарий к заказу
  $(document).on('click', '.comment-handler', function (e) {
    var comment = document.getElementById('comment');
    comment.classList.toggle('active');
  });
  
  // промокод (купон)
  $(document).on('click', '#handler-promo', function (e) {
    var promoCode = document.querySelector('#section-promo');
    promoCode.classList.toggle('active');
  });

  // промокод (voucher)
  $(document).on('click', '#handler-voucher', function (e) {
    var promoVoucher = document.querySelector('#section-voucher');
    promoVoucher.classList.toggle('active');
  });

  // купон
  $(document).on('change', '#coupon', function(){
      $('#confirm_coupon').trigger('click');
  });

  // voucher
  $(document).on('change', '#voucher', function(){
      $('#confirm_voucher').trigger('click');
  });

  $(document).on('click', '#confirm_coupon', function(event){
    // $('#promo_error').html('');
    $.ajax({
      url: '/index.php?route=checkout/coupon/coupon',
      type: 'post',
      data: 'coupon=' + encodeURIComponent($('input[name=\'coupon\']').val()),
      dataType: 'json',
      success: function(json) {
        console.log(json);
        if (json['error']) {
          $('#promo_error').html(json['error']);
        } else {
          $('#promo_error').html('');
        }
        refresh_totals();
      },
      error: function(xhr, ajaxOptions, thrownError) {
        console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      }
    });
    event.stopImmediatePropagation();
  });

  $(document).on('click', '#confirm_voucher', function() {
    // $('#promo_error').html('');
    $.ajax({
      url: '/index.php?route=checkout/voucher/voucher',
      type: 'post',
      data: 'voucher=' + encodeURIComponent($('input[name=\'voucher\']').val()),
      dataType: 'json',
      success: function(json) {
        console.log(json);
        if (json['error']) {
          $('#voucher_error').html(json['error']);
        } else {
          $('#voucher_error').html('');
        }
        refresh_totals();
      },
      error: function(xhr, ajaxOptions, thrownError) {
        console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      }
    });
  });

  function refresh_totals() {
      $.ajax({
          url: '/index.php?route=checkout/cart/refresh_totals',
          type: 'post',
          dataType: 'json',
          success: function (json) {
              // console.log(json);
              $('.cart-totals').html(json['totals']);
              $('.final-price').html(json['totals_total']);
          },
          error: function(xhr, ajaxOptions, thrownError) {
              console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
          }
      });
  }
  
});

var setTab = function (target) {
  $('.cart-froms-tab .tab').css('display','none');
  $(target).css('display','block');
};

// Autocomplete */
(function ($) {
  $.fn.autocomplete = function (option) {
    return this.each(function () {
      this.timer = null;
      this.items = new Array();

      $.extend(this, option);

      $(this).attr('autocomplete', 'off');

      // Focus
      $(this).on('focus', function () {
        this.request();
      });

      // Blur
      $(this).on('blur', function () {
        setTimeout(function (object) {
          object.hide();
        }, 200, this);
      });

      // Keydown
      $(this).on('keydown', function (event) {
        switch (event.keyCode) {
          case 27: // escape
            this.hide();
            break;
          default:
            this.request();
            break;
        }
      });

      // Click
      this.click = function (event) {
        event.preventDefault();

        value = $(event.target).parent().attr('data-value');

        if (value && this.items[value]) {
          this.select(this.items[value]);
        }
      }

      // Show
      this.show = function () {
        var pos = $(this).position();

        $(this).siblings('ul.dropdown-menu').css({
          top: pos.top + $(this).outerHeight(),
          left: pos.left
        });

        $(this).siblings('ul.dropdown-menu').show();
      }

      // Hide
      this.hide = function () {
        $(this).siblings('ul.dropdown-menu').hide();
      }

      // Request
      this.request = function () {
        clearTimeout(this.timer);

        this.timer = setTimeout(function (object) {
          object.source($(object).val(), $.proxy(object.response, object));
        }, 200, this);
      }

      // Response
      this.response = function (json) {
        html = '';

        if (json.length) {
          for (i = 0; i < json.length; i++) {
            this.items[json[i]['value']] = json[i];
          }

          for (i = 0; i < json.length; i++) {
            if (!json[i]['category']) {
              html += '<li data-value="' + json[i]['value'] + '"><a href="#">' + json[i]['label'] + '</a></li>';
            }
          }

          // Get all the ones with a categories
          var category = new Array();

          for (i = 0; i < json.length; i++) {
            if (json[i]['category']) {
              if (!category[json[i]['category']]) {
                category[json[i]['category']] = new Array();
                category[json[i]['category']]['name'] = json[i]['category'];
                category[json[i]['category']]['item'] = new Array();
              }

              category[json[i]['category']]['item'].push(json[i]);
            }
          }

          for (i in category) {
            html += '<li class="dropdown-header">' + category[i]['name'] + '</li>';

            for (j = 0; j < category[i]['item'].length; j++) {
              html += '<li data-value="' + category[i]['item'][j]['value'] + '"><a href="#">&nbsp;&nbsp;&nbsp;' + category[i]['item'][j]['label'] + '</a></li>';
            }
          }
        }

        if (html) {
          this.show();
        } else {
          this.hide();
        }

        $(this).siblings('ul.dropdown-menu').html(html);
      }

      $(this).after('<ul class="dropdown-menu"></ul>');
      $(this).siblings('ul.dropdown-menu').delegate('a', 'click', $.proxy(this.click, this));

    });
  }
})(window.jQuery);


/**
 * Edit step first
 **/
function editStepFirst() {

  /**
   * Get load firstStep
   **/
  $(document).ready(function () {
    $.ajax({
      url: '/index.php?route=checkout/step_first',
      type: 'post',
      data: {'step_second': false},
      dataType: 'html',
      success: function (html) {
        $('#step-1').html(html);
      },
      error: function (xhr, ajaxOptions, thrownError) {
        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      }
    });
  });

  // Unset secondStep
  $('#step-2').html('');

  // Unset confirm button
  $('#confirm-holder').html('');

}


/**
 * Confirm order
 */
$(document).on('click', '#button-confirm', function () {
  updateOrder();
});


/**
 * Update cart
 **/
function updateCart() {
  $.ajax({
    url: '/index.php?route=checkout/cart',
    dataType: 'html',
    success: function (html) {
      $('#cart-product').html(html);
    },
    error: function (xhr, ajaxOptions, thrownError) {
      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  });
}


/**
 * Update shipping Methods
 **/
function updateShippingMethods() {
  $.ajax({
    url: '/index.php?route=checkout/shipping/shippingMethods',
    dataType: 'html',
    success: function (html) {
      $('#shipping_methods').html(html);
    },
    error: function (xhr, ajaxOptions, thrownError) {
      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  });
}


/**
 * Update Payment Methods
 **/
function updatePaymentMethods() {
  $.ajax({
    url: '/index.php?route=checkout/payment/paymentMethods',
    dataType: 'html',
    success: function (html) {
      $('#payment_methods').html(html);
    },
    error: function (xhr, ajaxOptions, thrownError) {
      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  });
}



/**
 * Update Order
 **/
function updateOrder() {
  $.ajax({
    url: '/index.php?route=checkout/checkout/updateOrder',
    error: function (xhr, ajaxOptions, thrownError) {
      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  });
}


/**
 * Update Shipping Address - City
 **/
function updateShipping() {
  var data = $('*[name=\'city_ref\'], *[name=\'city\'], input[name=\'address_2[street]\'], input[name=\'address_2[house]\'], input[name=\'address_2[apartment]\']');
  $.ajax({
    url: '/index.php?route=checkout/checkout/updateShipping',
    type: 'post',
    data: data,
    dataType: 'json',
    success: function (json) {
      html = '';
      if (json['address'] && json['address'] != '' && json['address'] != 'undefined') {
        for (i = 0; i < json['address'].length; i++) {
          html += '<option value="' + json['address'][i]['name'] + '"';
          html += '>' + json['address'][i]['name'] + '</option>';
        }
      } else {
        html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
      }
      $('select[name=\'address_1\']').html(html);
      $('select[name=\'address_1\']').trigger('change');
    },
    error: function (xhr, ajaxOptions, thrownError) {
      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  });
}

$(function () {

  $(document).ready(function() {

    /**
     * Get load getTotalProducts Cart
     **/
    $.ajax({
      url: '/index.php?route=checkout/cart',
      dataType: 'html',
      success: function(html) {
        $('#cart-product').html(html);

        /**
         * Unset confirm button
         **/
        $('#confirm-holder').html('');
      },
      error: function(xhr, ajaxOptions, thrownError) {
        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      }
    });


    /**
     * Get load firstStep
     **/
    $.ajax({
      url: '/index.php?route=checkout/step_first',
      dataType: 'html',
      success: function(html) {
        $('#step-1').html(html);
      },
      error: function(xhr, ajaxOptions, thrownError) {
        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      }
    });

  });

  /**
   * Set account data to session
   **/
  $(document).on('change', 'input[name=\'firstname\'], input[name=\'telephone\'], input[name=\'email\'], input[name=\'password\'], textarea[name=\'comment\']', function() {
    var _this = $(this),
        _name = _this.attr('name');

    $.ajax({
      url: '/index.php?route=checkout/step_first/update',
      type: 'post',
      data: _this,
      dataType: 'json',
      success: function(json) {
        _this.next('.text-danger').remove();
        if ( json['error'] ) {
          if ( json['error'][_name] ) {
            $('input[name="' + _name + '"]').after('<div class="text-danger">' + json['error'][_name] + '</div>');
          }
        }
      },
      error: function(xhr, ajaxOptions, thrownError) {
        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      }
    });
  });

  /**
   * Set account
   **/
  $(document).on('change', 'input[name=\'account\']', function() {
    $.ajax({
      url: '/index.php?route=checkout/step_first/account',
      type: 'post',
      data: $('#type-account :input'),
      dataType: 'html',
      success: function(html) {
        $('#step-1').html(html);
      },
      error: function(xhr, ajaxOptions, thrownError) {
        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      }
    });
  });

  /**
   * Login
   **/
  $(document).delegate('#button-login', 'click', function() {
    $.ajax({
      url: '/index.php?route=checkout/login/save',
      type: 'post',
      data: $('#old-customer :input'),
      dataType: 'json',
      beforeSend: function() {
        $('#button-login').button('loading');
      },
      complete: function() {
        $('#button-login').button('reset');
      },
      success: function(json) {
        $('.alert, .text-danger').remove();
        $('#old-customer input').removeClass('has-error');

        if (json['redirect']) {
          location = json['redirect'];
        } else if (json['error']) {
          $('#old-customer').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');

          // Highlight any found errors
          $('input[name=\'email\']').parent().addClass('has-error');
          $('input[name=\'password\']').parent().addClass('has-error');
        }
      },
      error: function(xhr, ajaxOptions, thrownError) {
        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      }
    });
  });

  /**
   * Go second step
   **/
  $(document).on('click', '#second-step', function () {

    var data = $('input[name=\'firstname\'], input[name=\'telephone\'], input[name=\'email\'], input[name=\'password\'], input[name=\'confirm\'], input[name=\'country\'], input[name=\'zone\']');

    $.ajax({
      url: '/index.php?route=checkout/step_second/validate',
      type: 'post',
      data: data,
      dataType: 'json',
      success: function(json) {

        if (json['error']) {

          $.each(json['error'], function (key, value) {
            var _field = $("input[name='"+key+"']");
            _field.next('.text-danger').remove();
            _field.after('<div class="text-danger">' + value + '</div>');
          });
        }

        if (json['success']) {

          /**
           * Get load firstStep
           **/
          $.ajax({
            url: '/index.php?route=checkout/step_first',
            dataType: 'html',
            success: function(html) {
              $('#step-1').html(html);
            },
            error: function(xhr, ajaxOptions, thrownError) {
              alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
          });


          /**
           * Get load step second
           **/
          $.ajax({
            url: '/index.php?route=checkout/step_second',
            dataType: 'html',
            success: function(html) {
              $('#step-2').html(html);

              updateShippingMethods();
              updatePaymentMethods();
              updateCart();
              updateOrder();

            },
            error: function(xhr, ajaxOptions, thrownError) {
              alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
          });

        }

      },
      error: function(xhr, ajaxOptions, thrownError) {
        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      }
    });
  });
});

/**
 * Change shipping method
 **/
$(document).on('change', 'input[name=\'shipping_method\']', function() {
  $.ajax({
    url: '/index.php?route=checkout/shipping/saveShippingMethods',
    type: 'post',
    data: $('#shipping_methods input[type=\'radio\']:checked'),
    dataType: 'json',
    success: function(json) {
      $('.alert, .text-danger').remove();

      if (json['redirect']) {
        location = json['redirect'];
      } else if (json['error']) {
        if (json['error']['warning']) {
          $('.cart-holder').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
        }
      } else {
        updateShippingMethods();
        updatePaymentMethods();
        updateCart();
//                        updateOrder();
      }
    },
    error: function(xhr, ajaxOptions, thrownError) {
      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  });
});

/**
 * Change payment method
 **/
$(document).on('change', 'input[name=\'payment_method\']', function() {
  $.ajax({
    url: '/index.php?route=checkout/payment/savePaymentMethods',
    type: 'post',
    data: $('#payment_methods input[type=\'radio\']:checked'),
    dataType: 'json',
    success: function(json) {
      $('.alert, .text-danger').remove();

      if (json['redirect']) {
        location = json['redirect'];
      } else if (json['error']) {
        if (json['error']['warning']) {
          $('.cart-holder').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
        }
      } else {
//                        updateShippingMethods();
        updatePaymentMethods();
        updateCart();
//                        updateOrder();
      }
    },
    error: function(xhr, ajaxOptions, thrownError) {
      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  });

});

/**
 * Update Shipping Address - Address
 **/
$(document).on('change', 'select[name=\'address_1\']', function() {
  var data = $('*[name=\'city_ref\'], *[name=\'city\'], select[name=\'address_1\']');
  $.ajax({
    url: '/index.php?route=checkout/checkout/updateShipping',
    type: 'post',
    data: data,
    error: function(xhr, ajaxOptions, thrownError) {
      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  });
});

/**
 * Update Shipping Address - Address 2
 **/
$(document).on('change', 'input[name=\'address_2[street]\'], input[name=\'address_2[house]\'], input[name=\'address_2[apartment]\']', function() {
  var _this = $(this),
      _name = _this.attr('name'),
      data = $('input[name=\'address_2[street]\'], input[name=\'address_2[house]\'], input[name=\'address_2[apartment]\']');

  $.ajax({
    url: '/index.php?route=checkout/checkout/updateShipping',
    type: 'post',
    data: data,
    error: function(xhr, ajaxOptions, thrownError) {
      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  });
});