$(document).on('click', '#button_login_popup', function() {
	$.ajax({
		url: 'index.php?route=module/d_quickcheckout/login_validate',
		type: 'post',
		data: $('#option_login_popup input'),
		dataType: 'json',
		beforeSend: function() {
			$('#button_login_popup').attr('disabled', true);

		},
		complete: function() {
			$('#button_login_popup').attr('disabled', false);

		},
		success: function(json) {
			console.log(json)
			$('.alert').remove();
			if ("error" in json) {
				$('#option_login_popup .modal-body').prepend('<div class="alert alert-danger" style="display: none;">' + json['error']['warning'] + '</div>');
				$('.alert').fadeIn('slow');
			} else if(json['reload'])   {
				location.reload()
			} else {
				refreshAllSteps()
				$('#option_login_popup_wrap').fadeOut('slow')
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});