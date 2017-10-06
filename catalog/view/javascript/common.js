jQuery.extend(verge);
var desktop = true,
	tablet = false,
	mobile = false,
	tabletPortrait = false,
	headerHover = false;

$(window).resize(function () {
	if ($.viewportW() > 1240) {
		desktop = true;
		tablet = false;
		mobile = false;
		tabletPortrait = false;
	}

	if ($.viewportW() >= 768 && $.viewportW() <= 1240) {
		desktop = false;
		tablet = true;
		tabletPortrait = false;
		mobile = false;
	}

	if ($.viewportW() < 1000) {
		tabletPortrait = true;
	}

	if ($.viewportW() <= 767) {
		desktop = false;
		tablet = false;
		mobile = true;
		tabletPortrait = false;
	}

}).resize();

jQuery.fn.exist = function() {
	var exist;
	this.length >= 1 ? exist = true : exist = false;
	return exist;
};


// Exist function's
$(function () {

	var $element = $(".page.contact");
	if ( $element.exist() ) {

	}
});

function getURLVar(key) {
	var value = [];

	var query = String(document.location).split('?');

	if (query[1]) {
		var part = query[1].split('&');

		for (i = 0; i < part.length; i++) {
			var data = part[i].split('=');

			if (data[0] && data[1]) {
				value[data[0]] = data[1];
			}
		}

		if (value[key]) {
			return value[key];
		} else {
			return '';
		}
	}
}

function getFaqKey(key) {
	var value = [];

	var query = String(document.location).split('#');

	if (query[1]) {
		var part = query[1].split('-');

		if (part[1]) {
			return part[1];
		} else {
			return '';
		}
	}
}

$(document).on('click', '.qc-quantity button', function(event){
	event.preventDefault();
	var nub_quantity = parseInt($(this).parent().parent().children('#input-quantity-popup').val());
	var quantity = parseInt($(this).parent().parent().children('#input-quantity-popup').val()),
		key = $('#product-popup').data('key');

	if ($(this).is('.increase')) {
		quantity ++;
		$(this).parent().parent().children('#input-quantity-popup').val(quantity);
	} else if ($(this).is('.decrease')) {
		if(nub_quantity!='1') {
			quantity--;
			$(this).parent().parent().children('#input-quantity-popup').val(quantity > 0 ? quantity : 0);
		}
	}
	cart.update(key, quantity);
});

$(document).on('change', '.qc-quantity input', function(){
	var nub_quantity = parseInt($(this).val());
	var quantity = parseInt($(this).val()),
		key = $('#product-popup').data('key');

	if ($(this).is('.increase')) {
		quantity ++;
		$(this).val(quantity);
	} else if ($(this).is('.decrease')) {
		if(nub_quantity!='1') {
			quantity--;
			$(this).val(quantity > 0 ? quantity : 0);
		}
	}
	cart.update(key, quantity);
});

$(document).on('click', '#button-cart', function () {

	var button = $(this),
		body = $('body');

	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: $('#product input[type=\'text\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
		dataType: 'json',
		beforeSend: function () {
			$('#button-cart').button('loading');
		},
		complete: function () {
			$('#button-cart').button('reset');
		},
		success: function (json) {
			$('.alert, .text-danger').remove();
			$('.form-group').removeClass('has-error');

			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						var element = $('#input-option' + i.replace('_', '-'));

						if (element.parent().hasClass('input-group')) {
							element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						} else {
							element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						}
					}
				}

				if (json['error']['recurring']) {
					$('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
				}

				// Highlight any found errors
				$('.text-danger').parent().addClass('has-error');
			}

			if (json['success']) {

				setTimeout(function () {
					body.find('#cart > button').html('<i class="fa fa-shopping-cart"></i> ' + json['total']);

					button.addClass('in_cart').find('span').text(LANGS['default']['button_in_cart']);
				}, 300);

				$('#modal-cart')
					.addClass('cart-popup')
					.find('.modal-body')
						.html(json['success'])
					.end()
					.find('.modal-header .modal-title')
						.empty()
						.append($('#modal-cart .title'))
					.end()
					.find('.modal-footer')
						.empty()
						.append($('#modal-cart .cartFooter'))
					.end()
					.modal({show:true});

				body.find('#cart > ul').load('index.php?route=common/cart/info ul li');
			}
		}
	});
});

$(function () {
	jcf.replaceAll();
});

$(document).ready(function () {

	// Drop down text
	$(document).on('click', '#button-full', function () {
		$(this).toggleClass("active", 0);

		var element_height = $(this).attr( 'data-element'),
			element = $("[data-toggle-element='"+element_height+"']"),
			height_full = element.attr( 'data-height-full');
		height_short = element.attr( 'data-height-short');

		if ( $(this).hasClass('active') ) {
			$(this).children('span').text( $(this).attr('data-short-test') );
			$(this).children('i').removeClass('fa-angle-down');
			$(this).children('i').addClass('fa-angle-up');

			element.animate({
				height: height_full
			}, 500);
		}
		if ( !$(this).hasClass('active') ) {
			$(this).children('span').text( $(this).attr('data-full-test') );
			$(this).children('i').removeClass('fa-angle-up');
			$(this).children('i').addClass('fa-angle-down');

			element.animate({
				height: height_short
			}, 500);
		}
	});

	callme.init('#callme-button');

	cols1 = $('#column-right, #column-left').length;

	if (cols1 == 2) {
		$('#content .product-layout:nth-child(2n+2)').after('<div class="clearfix visible-md visible-sm"></div>');
	} else if (cols1 == 1) {
		$('#content .product-layout:nth-child(3n+4)').after('<div class="clearfix visible-lg"></div>');
	} else {
		$('#content .product-layout:nth-child(4n+4)').after('<div class="clearfix"></div>');
	}

	// Highlight any found errors
	$('.text-danger').each(function () {
		var element = $(this).parent().parent();

		if (element.hasClass('form-group')) {
			element.addClass('has-error');
		}
	});

	if ($(".descriptionBlock").height() < '420') {
		$('.descriptionMore').hide();
	} else {
		$('.descriptionBlock').addClass('descr-text');
		//$( ".descr-text").css({'height':'420px'})
	}

	// Drop down text
	$('#button-dt').on('click', function () {
		$(".descr-text").toggleClass("newClass", 500);
		$(this).toggleClass("active", 0);

		if ($("#button-dt").hasClass('active')) {
			$("#button-dt span").text($("#button-dt").attr('data-short-test'));
			$("#button-dt i").removeClass('fa-angle-down');
			$("#button-dt i").addClass('fa-angle-up');
		}
		if (!$("#button-dt").hasClass('active')) {
			$("#button-dt span").text($("#button-dt").attr('data-full-test'));
			$("#button-dt i").removeClass('fa-angle-up');
			$("#button-dt i").addClass('fa-angle-down');
		}
	});

	// Currency
	$('#currency .currency-select').on('click', function (e) {
		e.preventDefault();

		$('#currency input[name=\'code\']').attr('value', $(this).attr('name'));

		$('#currency').submit();
	});

	// Language
	$('#language a').on('click', function (e) {
		e.preventDefault();

		$('#language input[name=\'code\']').attr('value', $(this).attr('href'));

		$('#language').submit();
	});

	/* Search */
	$('#search input[name=\'search\']').parent().find('button').on('click', function () {
		url = $('base').attr('href') + 'index.php?route=product/search';
		var value = $('#search input[name=\'search\']').val();
		if (value) {
			url += '&search=' + encodeURIComponent(value);
		}
		location = url;
	});

	$('#search input[name=\'search\']').on('keydown', function (e) {
		if (e.keyCode == 13) {
			$('header input[name=\'search\']').parent().find('button').trigger('click');
		}
	});

	// Menu
	$('#menu .dropdown-menu').each(function () {
		var menu = $('#menu').offset();
		var dropdown = $(this).parent().offset();

		var i = (dropdown.left + $(this).outerWidth()) - (menu.left + $('#menu').outerWidth());

		if (i > 0) {
			$(this).css('margin-left', '-' + (i + 5) + 'px');
		}
	});

	// Product List
	$('#list-view').click(function () {
		$('#content .product-layout > .clearfix').remove();
		$('#content .row > .product-layout').attr('class', 'product-layout product-list col-xs-12');
		setTimeout(function () {
			var max_product_height = 0;
			$('.product-layoutBlock > .product-layout').each(function () {
				var product_height = parseInt($(this).height());
				if (product_height > max_product_height) {
					max_product_height = product_height;
				}
			});
			$('.product-layoutBlock > .product-layout').css({'height': 'auto'});
		}, 300);
		localStorage.setItem('display', 'list');
	});

	// Product Grid
	$('#grid-view').click(function () {
		$('#content .product-layout > .clearfix').remove();
		cols = $('#column-right, #column-left').length;
		if (cols == 2) {
			$('#content .product-layout').attr('class', 'product-layout product-grid col-sm-4');
		} else if (cols == 1) {
			$('#content .product-layout').attr('class', 'product-layout product-grid col-sm-4');
		} else {
			$('#content .product-layout').attr('class', 'product-layout product-grid col-sm-3');
		}
		setTimeout(function () {
			var max_product_height = 0;
			$('.product-layoutBlock > .product-layout').each(function () {
				var product_height = parseInt($(this).height());
				if (product_height > max_product_height) {
					max_product_height = product_height;
				}
			});
			$('.product-layoutBlock > .product-layout').height(max_product_height + 'px');
		}, 300);
		localStorage.setItem('display', 'grid');
	});

	if (localStorage.getItem('display') == 'list') {
		$('#list-view').trigger('click');
	} else {
		$('#grid-view').trigger('click');
	}

	// tooltips on hover
	$('[data-toggle=\'tooltip\']').tooltip({container: 'body'});

	// Makes tooltips work on ajax generated content
	$(document).ajaxStop(function () {
		$('[data-toggle=\'tooltip\']').tooltip({container: 'body'});
	});
});

// Cart add remove functions
var cart = {
	'add': function (product_id, quantity) {
		var button,
			body = $('body');

		$.ajax({
			url: 'index.php?route=checkout/cart/add',
			type: 'post',
			data: 'product_id=' + product_id + '&quantity=' + (typeof(quantity) != 'undefined' ? quantity : 1),
			dataType: 'json',
			beforeSend: function () {
				$('#cart > button').button('loading');
			},
			complete: function () {
				$('#cart > button').button('reset');
			},
			success: function (json) {
				$('.alert, .text-danger').remove();

				if (json['redirect']) {
					location = json['redirect'];
				}

				if (json['success']) {

					setTimeout(function () {
						body.find('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');

						button = $('[onclick="cart.add(\'' + product_id + '\');"]');
						button.addClass('in_cart').find('span').text(LANGS['default']['button_in_cart']);
					}, 300);

					body.find('#cart > ul').load('index.php?route=common/cart/info ul li');

					body.find('#modal-cart')
						.find('.modal-body')
							.html(json['success'])
						.end()
						.find('.modal-header .modal-title')
							.empty()
							.append($('#modal-cart .title'))
						.end()
						.find('.modal-footer')
							.empty()
							.append($('#modal-cart .cartFooter'))
						.end()
						.modal({show:true});
				}
			}
		});
	},
	'update': function (key, quantity) {
		$.ajax({
			// url: 'index.php?route=checkout/cart/edit',
			url: 'index.php?route=checkout/cart/refresh',
			type: 'post',
			data: 'key=' + key + '&quantity=' + (typeof(quantity) != 'undefined' ? quantity : 1),
			dataType: 'json',
			beforeSend: function () {
				$('#cart > button').button('loading');
			},
			complete: function () {
				$('#cart > button').button('reset');
			},
			success: function (json) {
				// Need to set timeout otherwise it wont update the total
				setTimeout(function () {
					$('.cart-popup .price-total .value').html(json['product_total']);
					$('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
				}, 100);

				if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
					location = 'index.php?route=checkout/cart';
				} else {
					$('#cart > ul').load('index.php?route=common/cart/info ul li');
				}
			}
		});
	},
	'remove': function (key) {

		var body = $('body'),
			button;

		$.ajax({
			url: 'index.php?route=checkout/cart/remove',
			type: 'post',
			data: 'key=' + key,
			dataType: 'json',
			beforeSend: function () {
				$('#cart > button').button('loading');
			},
			complete: function () {
				$('#cart > button').button('reset');
			},
			success: function (json) {

				// Need to set timeout otherwise it wont update the total
				setTimeout(function () {
					body.find('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');

					button = $('[data-product-id="' + json['product_id'] + '"]');
					button.removeClass('in_cart').find('span').text(LANGS['default']['button_cart']);
				}, 300);

				if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
					location = 'index.php?route=checkout/cart';
				} else {
					$('#cart > ul').load('index.php?route=common/cart/info ul li');
				}
			}
		});
	}
}

var voucher = {
	'add': function () {

	},
	'remove': function (key) {
		$.ajax({
			url: 'index.php?route=checkout/cart/remove',
			type: 'post',
			data: 'key=' + key,
			dataType: 'json',
			beforeSend: function () {
				$('#cart > button').button('loading');
			},
			complete: function () {
				$('#cart > button').button('reset');
			},
			success: function (json) {
				// Need to set timeout otherwise it wont update the total
				setTimeout(function () {
					$('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
				}, 100);

				if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
					location = 'index.php?route=checkout/cart';
				} else {
					$('#cart > ul').load('index.php?route=common/cart/info ul li');
				}
			}
		});
	}
};

var wishlist = {
	'add': function (product_id) {
		var button;
		$.ajax({
			url: 'index.php?route=account/wishlist/add',
			type: 'post',
			data: 'product_id=' + product_id,
			dataType: 'json',
			success: function (json) {
				$('.alert').remove();

				if (json['success']) {
					$('#content').parent().before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				}

				if (json['info']) {
					$('#content').parent().before('<div class="alert alert-info"><i class="fa fa-info-circle"></i> ' + json['info'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				}

				button = $('[onclick="wishlist.add(\'' + product_id + '\');"]');

				button.addClass('in_wishlist').find('span').text(LANGS['default']['button_in_wishlist']);
				button.attr('onclick', "wishlist.remove('" + product_id + "');");

				$('#wishlist-total span').html(json['total']);
				$('#wishlist-total').attr('title', json['total']);

				$('html, body').animate({scrollTop: 0}, 'slow');
			}
		});
	},
	'remove': function (product_id) {
		var button;

		if (confirm("Вы подтверждаете удаление?")) {
			$.ajax({
				url: 'index.php?route=account/wishlist/remove',
				type: 'post',
				data: 'product_id=' + product_id,
				dataType: 'json',
				success: function (json) {
					$('.alert').remove();

					if (json['success']) {
						$('#content').parent().before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
					}

					button = $('[onclick="wishlist.remove(\'' + product_id + '\');"]');

					button.removeClass('in_wishlist').find('span').text(LANGS['default']['button_wishlist']);
					button.attr('onclick', "wishlist.add('" + product_id + "');");

					$('html, body').animate({scrollTop: 0}, 'slow');
				}
			});
		}

	}
};

var compare = {
	'add': function (product_id) {
		$.ajax({
			url: 'index.php?route=product/compare/add',
			type: 'post',
			data: 'product_id=' + product_id,
			dataType: 'json',
			success: function (json) {
				$('.alert').remove();

				if (json['success']) {
					$('#content').parent().before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');

					$('#compare-total').html(json['total']);

					$('html, body').animate({scrollTop: 0}, 'slow');
				}
			}
		});
	},
	'remove': function () {

	}
}

/* Agree to Terms */
$(document).delegate('.agree', 'click', function (e) {
	e.preventDefault();

	$('#modal-agree').remove();

	var element = this;

	$.ajax({
		url: $(element).attr('href'),
		type: 'get',
		dataType: 'html',
		success: function (data) {
			html = '<div id="modal-agree" class="modal">';
			html += '  <div class="modal-dialog">';
			html += '    <div class="modal-content">';
			html += '      <div class="modal-header">';
			html += '        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>';
			html += '        <h4 class="modal-title">' + $(element).text() + '</h4>';
			html += '      </div>';
			html += '      <div class="modal-body">' + data + '</div>';
			html += '    </div';
			html += '  </div>';
			html += '</div>';

			$('body').append(html);

			$('#modal-agree').modal('show');
		}
	});
});

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

/* Top Div Arrow */
jQuery(document).ready(function(){
	// hide #back-top first
	jQuery("#topon").hide();
	// fade in #back-top
	jQuery(function () {
		jQuery(window).scroll(function () {
			if (jQuery(this).scrollTop() > 100) {
				jQuery('#topon').fadeIn();
			} else {
				jQuery('#topon').fadeOut();
			}
		});

		// scroll body to 0px on click
		jQuery('#topon a').click(function () {
			jQuery('body,html').animate({
				scrollTop: 0
			}, 800);
			return false;
		});
	});
});