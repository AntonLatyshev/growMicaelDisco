
$(window).on('load', function () {
    //initial
    var item = {
        elementWrapper: $('#column-left ul > li.children'),//wrapper
        hideElement: $('.text-holder'),//hide element
        height: 0,
        margintop: 0,
        button: '.opener',//opener button
        speed: 400,
        init: function () {
            openClose(this);
        }
    };
    item.init();
    //end of initial
    function openClose(options) {

        options.elementWrapper.each(function () {
            var originalHeight,
                _hideElement;
            _hideElement = $(this).find(options.hideElement);
            originalHeight = _hideElement.height();

            _hideElement.height(options.height);

            _hideElement.data('data-original-height', originalHeight);
        });

        var button = options.elementWrapper.find(options.button);

        button.on('click', function () {
            var _self = $(this);
            var height = $(this).closest(options.elementWrapper).find(options.hideElement).data('data-original-height');
            $(this).closest(options.elementWrapper).find(options.hideElement).animate({
                height: $(this).hasClass('active') ? options.height : height,
                marginTop: $(this).hasClass('active') ? 0 : 8
            }, options.speed, function () {
                _self.toggleClass('active');
                _self.parent().toggleClass('active');
                _self.hasClass('active') ? _self.text(_self.data('close')) : _self.text(_self.data('open'));
            });
        });

        $('li.children.active-page').find('.opener').trigger('click');
        if (window.templateFlag) {
            $('li.children').find('.opener').trigger('click');
        }

    }

});


