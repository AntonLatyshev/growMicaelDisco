
document.addEventListener('DOMContentLoaded', cart);
var workTimeHandler = document.querySelector('.handler-work-time');
var workTimePopup = document.querySelector('.cart-work-time__popup');
var cartNavItem = document.querySelectorAll('.form-tab-nav a');
var cartNavListItem = document.querySelectorAll('.form-tab-nav li');
var tabElement = document.querySelectorAll('.cart-froms-tab .tab');
var registerChekbox = document.getElementById('with-register');
var hiddenRow = document.getElementsByClassName('hidden-row');
var loginForm = document.getElementById('login-form');
var loginSucces = document.querySelector('.login-success');
var notLogin = document.querySelector('.not-login');
var countHandler = document.querySelectorAll('.handler-holder .handler');
var countInput = document.getElementById('count-edit');
var priceEditTotal = document.querySelector('.edit-item .price-total em');
var priceEditItem = document.querySelector('.edit-item .price-for-item em');
var cartPopup = document.querySelector('.cart-popup-holder');
var editHandlerElement = document.querySelectorAll('.info-row .edit');
var closeFromElements = document.querySelectorAll('.cart-popup-holder .overlay, .cart-popup-holder .close-btn,.cart-popup-holder .back');
var infoIcon = document.querySelectorAll('.cart-page .info');
var step1 = document.querySelector('.step-1');
var step2 = document.querySelector('.step-2');
var stepEdit = step1.querySelector('.edit');
var commentHandler = document.querySelector('.comment-handler');
var comment = document.getElementById('comment');
var totalHolder = document.querySelector('.total-holder');
var deliveryType = document.querySelectorAll('input[name=delivery]');
var promoHandler = document.querySelector('.promo-handler');
var promoCode = document.querySelector('.promo-code');

var countValue = null;

export default function cart() {
  if(!NodeList.prototype.forEach){
      NodeList.prototype.forEach = Array.prototype.forEach;
  }

  // workTimeHandler.addEventListener('click', function() {
  //   workTimePopup.classList.toggle('active');
  // });

  registerChekbox.addEventListener('click', function() {
    if (registerChekbox.checked) {
      hiddenRow[0].classList.add('active');
    } else {
      hiddenRow[0].classList.remove('active');
    }
  });

  cartNavListItem.forEach(function(el) {
    el.addEventListener('click', function(event) {
      if (!el.classList.contains('active')) {
        [].map.call(cartNavListItem, function(element) {
          if (element.classList.contains('active')) {
            element.classList.remove('active');
          }
          el.classList.add('active');
        });
      }
    });
  });

  cartNavItem.forEach(function(el) {
    el.addEventListener('click', function(event) {
      event.preventDefault();
      if (!el.parentNode.classList.contains('active')) {
        (function() {
          tabElement.forEach(function(item) {
            item.classList.remove('active');
          });
          var currentTabId = event.target.getAttribute('href');
            document.querySelector(currentTabId).classList.toggle('active');
        })();
      }
    });
  });

  countHandler.forEach(function(el) {
    el.addEventListener('click', function(event) {
      countValue = countInput.value;
      if (el.classList.contains('inc')) {
        calculateCount('inc', countValue);
      } else if (el.classList.contains('dec')) {
        calculateCount('dec', countValue);
      }
    });
  });


  function calculateCount(event, value) {
    if (event === 'inc') {
      countInput.value = parseInt(value, 10) + 1;
      setPricewhenEdit(countInput.value);
    } else if (event === 'dec' && value > 1) {
      countInput.value = parseInt(value, 10) - 1;
      setPricewhenEdit(countInput.value);
    }
  }

  function setPricewhenEdit(value) {
    var priceItem = priceEditItem.textContent;
    priceEditTotal.textContent = priceItem * value;
  }

  // on change count
  countInput.addEventListener('keyup', function(event) {
    setPricewhenEdit(countInput.value);
  });

  // close popup
  closeFromElements.forEach(function(el) {
    el.addEventListener('click', function(event) {
      cartPopup.classList.toggle('active');
    });
  });

  // open popup
  editHandlerElement.forEach(function(el) {
    el.addEventListener('click', function(event) {
      cartPopup.classList.toggle('active');
    });
  });

  function editLoginInfo() {
    step1.querySelector('.edit').classList.toggle('active');
    step1.classList.toggle('disabled');
  }

  loginForm.addEventListener('submit', function(event) {
    event.preventDefault();
    // Допустим я залогинелся
    loginSucces.style.display = 'block';
    notLogin.style.display = 'none';
    step2.style.display = 'block';
    totalHolder.classList.add('active');
    editLoginInfo();
  });

  stepEdit.addEventListener('click', function(event) {
    editLoginInfo();
  });

  document.querySelector('.login-success').addEventListener('submit', function(event) {
    event.preventDefault();
    // допустим я отредактировал свои данные
    editLoginInfo();
  });

  infoIcon.forEach(function(el) {
    el.addEventListener('click', function(event) {
      el.classList.toggle('active');
    });
  });

  deliveryType.forEach(function(el) {
    el.addEventListener('click', function(event) {
      var id = el.getAttribute('id');
      if (!el.classList.contains('active')) {
        [].map.call(deliveryType, function(element) {
          if (element.classList.contains('active')) {
            element.classList.remove('active');
          }
          el.classList.add('active');
        });

        [].map.call(document.querySelectorAll('.step-hidden .select'), function(element) {
          if (element.getAttribute('data-radio') === id) {
            element.classList.add('active');
          } else {
            element.classList.remove('active');
          }
        });
      }
    });
  });

  commentHandler.addEventListener('click', function(event) {
    comment.classList.toggle('active');
  });

  promoHandler.addEventListener('click', function(event) {
    promoCode.classList.toggle('active');
  });
}
