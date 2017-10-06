$(document).ready(function() {
    var class_page = false;
    var title_page = false;
    $('.ajaxPage').click(function(){
        var href = $(this).attr('href');
        var class_page = $(this).data('page');
        var title_page = $(this).data('title');
        $('#myModal .modal-body').load(href,function(result){
            jcf.replace('input[type="checkbox"]:not(".my-checkbox")');
            jcf.replace('input[type="radio"]');
            jcf.replace('select');
            $('#myModal').modal({show:true}).addClass(class_page);
            if ( title_page ) {
                $('#myModal .modal-title').html(title_page);
            }
            if ( class_page && class_page == 'fast-review' ) {
                $('#myModal .modal-footer').html('<a href="' + href + '" class="btn btn-link"><span>Больше информации о товаре</span></a>');
            }
        });
        return false;
    });
});