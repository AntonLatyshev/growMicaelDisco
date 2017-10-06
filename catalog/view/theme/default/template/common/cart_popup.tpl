<div class="row content-inside">
	<form method="post" action="#" name="cart_products" class="cartProductsForm">
		<div class="col-xs-6 left-inside">
			<div class="row chars-one">
				<div class="col-xs-12 thumbBlock">
					<div class="thumb">
						<?php echo $product['promo_tag_product_top_right'] ?>
						<a class="thumbnail" href="<?php echo $product['href']; ?>" title="<?php echo $product['name']; ?>">
							<img src="<?php echo $product['image']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>">
						</a>
					</div>
				</div>
			</div>
		</div>
		<div id="product-popup" class="col-xs-6 right-inside" data-key="<?php echo $product['key'] ?>">
			<span class="title"><?php echo $product['name']; ?></span>
			<div class="options-block">
				<?php if ($product['option']) { ?>
					<div class="options">
						<dl class="dl-horizontal">
							<?php foreach ($product['option'] as $option) { ?>
								<dt><?php echo $option['name']; ?>:</dt>
								<dd><?php echo $option['value']; ?></dd>
							<?php } ?>
						</dl>
					</div>
				<?php } ?>
			</div>
			<div class="checkout-block">
				<div class="item-layout qc-quantity">
					<div class="input-group">
						<span class="input-group-btn"><button class="btn btn-defaut decrease"><i class="fa fa-minus"></i></button></span>
						<input name="product_id" value="<?php echo $product['product_id'] ?>" type="hidden">
						<input name="quantity" value="<?php echo $product['quantity'] ?>" size="2" id="input-quantity-popup" class="form-control" data-refresh="2" type="text" />
						<span class="input-group-btn"><button class="btn btn-defaut increase"><i class="fa fa-plus"></i></button></span>
					</div>
				</div>

				<div class="price-layout col-xs-12">
					<div class="price-single col-xs-12">
						<div class="col-xs-5 label">Цена за 1 ед.:</div>
						<div class="col-xs-7 value"><?php echo $product['price'] ?></div>
					</div>
					<div class="price-total col-xs-12">
						<div class="col-xs-5 label">Общая цена:</div>
						<div class="col-xs-7 value"><?php echo $product['total'] ?></div>
					</div>
				</div>
			</div>	
		</div>
		<div class="cartFooter row">
			<div class="col-xs-6 text-left">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><?php echo $button_continue; ?></button>
			</div>
			<div class="col-xs-6 text-right">
				<a href="<?php echo $checkout ?>" class="btn btn-green btn-large"><span><?php echo $button_checkout; ?></span></a>
			</div>
		</div>
	</form>
</div>