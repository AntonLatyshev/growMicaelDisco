const validation = () => {
  const patternName = /^[a-zA-Zа-яА-Я'][a-zA-Zа-яА-Я-' ]+[a-zA-Zа-яА-Я']?$/u;
  const patternPhone = /^\+\+?(\d){12}$/;
  const patternMail = /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i;
  const patternTextarea = /^[a-zA-Zа-яА-Я'][a-zA-Zа-яА-Я-' ]+[a-zA-Zа-яА-Я']?$/u;

  function validateName(e) {
    if (this.val() != '') {
      if (this.val().match(patternName)) {
        this.closest('.callback__block').removeClass('error');
        return true;
      } else {
        this.closest('.callback__block').addClass('error');
      }
    } else {
      this.closest('.callback__block').addClass('error');
    }
  }

  function validatePhone(e) {
    if (this.val() != '') {
      if (this.val().match(patternPhone)) {
        this.closest('.callback__block').removeClass('error');
        return true;
      } else {
        this.closest('.callback__block').addClass('error');
      }
    } else {
      this.closest('.callback__block').addClass('error');
    }
  }

  function validateMail(e) {
    if (this.val() != '') {
      if (this.val().match(patternMail)) {
        this.closest('.callback__block').removeClass('error');
        return true;
      } else {
        this.closest('.callback__block').addClass('error');
      }
    } else {
      this.closest('.callback__block').addClass('error');
    }
  }

  function validateTextarea(e) {
    if (this.val() != '') {
      this.closest('.callback__block').removeClass('error');
      return true;
    } else {
      this.closest('.callback__block').addClass('error');
    }
  }

  $('.callback__form').each(function(i, el) {
    var name = $(el).find('[name="callback__form-name"]');
    var phone = $(el).find('[name="callback__form-phone"]');
    var textarea = $(el).find('[name="callback__form-textarea"]');
    $(el).find('.callback__submit').on('click', function(e) {
      var arr = [];
      validateName.call(name) ? arr.push(true) : false;
      validatePhone.call(phone) ? arr.push(true) : false;
      validateTextarea.call(textarea) ? arr.push(true) : false;
      console.log(arr.length);
      if (arr.length < 3) {
        e.preventDefault();
      } else {
        e.preventDefault();
        setTimeout("$('.thanks').addClass('show');", 200);
        $('.callback').removeClass('show');
        setTimeout(function() {
          $('.thanks').stop().removeClass('show');
          $('body').removeClass('overflow');
        }, 2000);
      }
    });
    name.on('keyup', validateName.bind(name));
    phone.on('keyup', validatePhone.bind(phone));
    textarea.on('keyup', validateTextarea.bind(textarea));
  });
}
export default validation;
