<div class="cart-popup-holder">
	<div class="overlay"></div>
	<div class="cart-edit">
		<div class="close-btn"></div>
		<div class="product-edit">
			<?php if (!empty($product)) { ?>
			<input type="hidden" id="key" value="<?php echo $product['key']; ?>">
			<div class="image">
				<img src="<?php echo $product['thumb']; ?>" alt="name">
			</div>
			<div class="info-box">
				<span class="edit-title"><?php echo $text_edit; ?></span>
				<a href="<?php echo $product['href']; ?>" class="name"><?php echo $product['name']; ?></a>
				<div class="info-row">
					<div class="info-item"><span><?php echo $text_model; ?></span> <?php echo $product['model']; ?></div>
				</div>
				<div class="edit-row">
					<div class="edit-item">
						<span class="label"><?php echo $text_price; ?></span>
						<span class="price-for-item"><em><?php echo $product['price_d']; ?></em><?php echo $product['price_s']; ?></span>
					</div>
					<div class="edit-item">
						<span class="label"><?php echo $text_quantity; ?></span>
						<div class="cart-count-holder">
							<input type="number" pattern="[0-9]*" value="<?php echo $product['quantity']; ?>" id="count-edit">
							<div class="handler-holder">
								<span class="inc handler"></span>
								<span class="dec handler"></span>
							</div>
						</div>
					</div>
					<div class="edit-item">
						<span class="label"><?php echo $text_total; ?></span>
						<span class="price-total"><em><?php echo $product['total_d']; ?></em><?php echo $product['total_s']; ?></span>
					</div>
				</div>
			</div>
			<?php } ?>
		</div>
		<div class="popup-buttons">
			<button class="back"><?php echo $button_back; ?></button>
			<button class="save"><?php echo $button_save; ?></button>
		</div>
	</div>
</div>

<script>
	$('.close-btn, .overlay, .back').click(function() {
		$('.cart-popup-holder').hide();
	});
</script>

<script>
	var countHandler = document.querySelectorAll('.handler-holder .handler');
	var countInput = document.getElementById('count-edit');
	var priceEditTotal = document.querySelector('.edit-item .price-total em');
	var priceEditItem = document.querySelector('.edit-item .price-for-item em');
	var countValue = null;

	var cartKey = document.getElementById('key');
//	var priceOrderCart = document.querySelector('.price');

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
	if(countInput) {
		countInput.addEventListener('keyup', function(event) {
		  	setPricewhenEdit(countInput.value);
		});
	}

	$('.save').click(function() {
		$.ajax({
			url: '/index.php?route=checkout/cart/refresh_popup_data',
			type: 'post',
			data: 'key=' + cartKey.value + '&quantity=' + countInput.value,
			dataType: 'json',
			success: function(json) {
				$('.quantity_' + json['product_id']).html(json['quantity']);
				$('.price_' + json['product_id']).html(json['product_total']);
				$('.cart-totals').html(json['totals']);
				$('.final-price').html(json['totals_total']);
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
		
		$('.cart-popup-holder').hide();
	});
	
</script>