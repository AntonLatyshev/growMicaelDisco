<?php if (!$isXhr) { ?>
	<?php echo $header; ?>
	<div class="container">
		<ul class="breadcrumb">
			<?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
				<li><?php if($i+1<count($breadcrumbs)) { ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a> <?php } else { ?><span><?php echo $breadcrumb['text']; ?></span><?php } ?></li>
			<?php } ?>
		</ul>
		<div id="ajaxView" class="row"><?php echo $column_left; ?>
			<?php if ($column_left && $column_right) { ?>
				<?php $class = 'col-sm-6'; ?>
			<?php } elseif ($column_left || $column_right) { ?>
				<?php $class = 'col-sm-9'; ?>
			<?php } else { ?>
				<?php $class = 'col-sm-12'; ?>
			<?php } ?>
			<div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
				<?php } ?>
				<div class="row">
					<?php if ($column_left && $column_right) { ?>
						<?php $class = 'col-sm-6'; ?>
					<?php } elseif ($column_left || $column_right) { ?>
						<?php $class = 'col-sm-6'; ?>
					<?php } else { ?>
						<?php $class = 'col-sm-8'; ?>
					<?php } ?>
					<div class="<?php echo $class; ?>">
						<?php if ($thumb || $images) { ?>
							<ul class="thumbnails">
								<?php print $promo_tag_product_top_right; ?>
								<?php if ($thumb) { ?>
									<li><a class="thumbnail gallery-element" href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>"><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>"  class="img_main"/></a></li>
								<?php } ?>
								<?php if ($images) { ?>
									<?php foreach ($images as $image) { ?>
										<li class="image-additional"><a class="thumbnail gallery-element" href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>"> <img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a></li>
									<?php } ?>
								<?php } ?>
							</ul>
						<?php } ?>
						<?php echo $product_series; ?>
						<ul class="nav nav-tabs">
							<li class="active"><a href="#tab-description" data-toggle="tab"><?php echo $tab_description; ?></a></li>
							<?php if ($attribute_groups) { ?>
								<li><a href="#tab-specification" data-toggle="tab"><?php echo $tab_attribute; ?></a></li>
							<?php } ?>
							<?php if ($review_status) { ?>
								<li><a href="#tab-review" data-toggle="tab"><?php echo $tab_review; ?></a></li>
							<?php } ?>
						</ul>
						<div class="tab-content">
							<div class="tab-pane active" id="tab-description"><?php echo $description; ?></div>
							<?php if ($attribute_groups) { ?>
								<div class="tab-pane" id="tab-specification">
									<table class="table table-bordered">
										<?php foreach ($attribute_groups as $attribute_group) { ?>
											<thead>
											<tr>
												<td colspan="2"><strong><?php echo $attribute_group['name']; ?></strong></td>
											</tr>
											</thead>
											<tbody>
											<?php foreach ($attribute_group['attribute'] as $attribute) { ?>
												<tr>
													<td><?php echo $attribute['name']; ?></td>
													<td><?php echo $attribute['text']; ?></td>
												</tr>
											<?php } ?>
											</tbody>
										<?php } ?>
									</table>
								</div>
							<?php } ?>
							<?php if ($review_status) { ?>
								<div class="tab-pane" id="tab-review">
									<form class="form-horizontal" id="form-review">
										<div id="review"></div>
										<h2><?php echo $text_write; ?></h2>
										<?php if ($review_guest) { ?>
											<div class="form-group required">
												<div class="col-sm-12">
													<label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
													<input type="text" name="name" value="" id="input-name" class="form-control" />
												</div>
											</div>
											<div class="form-group required">
												<div class="col-sm-12">
													<label class="control-label" for="input-review"><?php echo $entry_review; ?></label>
													<textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
													<div class="help-block"><?php echo $text_note; ?></div>
												</div>
											</div>
											<div class="form-group required">
												<div class="col-sm-12">
													<label class="control-label"><?php echo $entry_rating; ?></label>
													&nbsp;&nbsp;&nbsp; <?php echo $entry_bad; ?>&nbsp;
													<input type="radio" name="rating" value="1" />
													&nbsp;
													<input type="radio" name="rating" value="2" />
													&nbsp;
													<input type="radio" name="rating" value="3" />
													&nbsp;
													<input type="radio" name="rating" value="4" />
													&nbsp;
													<input type="radio" name="rating" value="5" />
													&nbsp;<?php echo $entry_good; ?></div>
											</div>
											<?php if ($site_key) { ?>
												<div class="form-group">
													<div class="col-sm-12">
														<div class="g-recaptcha" data-sitekey="<?php echo $site_key; ?>"></div>
													</div>
												</div>
											<?php } ?>
											<div class="buttons clearfix">
												<div class="pull-right">
													<button type="button" id="button-review" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><?php echo $button_continue; ?></button>
												</div>
											</div>
										<?php } else { ?>
											<?php echo $text_login; ?>
										<?php } ?>
									</form>
								</div>
							<?php } ?>
						</div>
					</div>
					<?php if ($column_left && $column_right) { ?>
						<?php $class = 'col-sm-6'; ?>
					<?php } elseif ($column_left || $column_right) { ?>
						<?php $class = 'col-sm-6'; ?>
					<?php } else { ?>
						<?php $class = 'col-sm-4'; ?>
					<?php } ?>
					<div class="<?php echo $class; ?>">
						<div class="btn-group">
							<button type="button" data-toggle="tooltip" class="btn btn-default<?php echo ($in_wishlist) ? ' in_wishlist' : ''; ?>" title="<?php echo $button_wishlist; ?>" onclick="wishlist.<?php echo ($in_wishlist) ? 'remove' : 'add'; ?>('<?php echo $product_id; ?>');"><i class="fa fa-heart"></i></button>
							<button type="button" data-toggle="tooltip" class="btn btn-default" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product_id; ?>');"><i class="fa fa-exchange"></i></button>
						</div>
						<h1><?php echo $heading_title; ?></h1>
						<ul class="list-unstyled">
							<?php if ($manufacturer) { ?>
								<li><?php echo $text_manufacturer; ?> <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a></li>
							<?php } ?>
							<li><?php echo $text_model; ?> <?php echo $model; ?></li>
							<?php if ($reward) { ?>
								<li><?php echo $text_reward; ?> <?php echo $reward; ?></li>
							<?php } ?>
							<li><?php echo $text_stock; ?> <?php echo $stock; ?></li>
						</ul>
						<?php if ($price) { ?>
							<ul class="list-unstyled">
								<?php if (!$special) { ?>
									<li>
										<h2><span id="formated_price" price="<?php echo $price_value; ?>"><?php echo $price; ?></span></h2>
									</li>
								<?php } else { ?>
									<li><span style="text-decoration: line-through;"><?php echo $price; ?></span></li>
									<li>
										<h2><span id="formated_special" price="<?php echo $special_value; ?>"><?php echo $special; /**/ ?></span></h2>
									</li>
								<?php } ?>
								<?php if ($tax) { ?>
									<li><?php echo $text_tax; ?> <?php echo $tax; ?></li>
								<?php } ?>
								<?php if ($points) { ?>
									<li><?php echo $text_points; ?> <?php echo $points; ?></li>
								<?php } ?>
								<?php if ($discounts) { ?>
									<li>
										<hr>
									</li>
									<?php foreach ($discounts as $discount) { ?>
										<li><?php echo $discount['quantity']; ?><?php echo $text_discount; ?><?php echo $discount['price']; ?></li>
									<?php } ?>
								<?php } ?>
							</ul>
						<?php } ?>
						<div id="product">
							<?php if ($options) { ?>
								<hr>
								<h3><?php echo $text_option; ?></h3>
								<?php foreach ($options as $option) { ?>
									<?php if ($option['type'] == 'select') { ?>
										<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> <?php echo $option['style'] ?>">
											<label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
											<select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
												<option value=""><?php echo $text_select; ?></option>
												<?php foreach ($option['product_option_value'] as $option_value) { ?>
													<option value="<?php echo $option_value['product_option_value_id']; ?>"  points="<?php echo (isset($option_value['points_value']) ? $option_value['points_value'] : 0); ?>" price_prefix="<?php echo $option_value['price_prefix']; ?>" price="<?php echo $option_value['price_value']; ?>"><?php echo $option_value['name']; ?>
														<?php if ($option_value['price']) { ?>
															(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
														<?php } ?>
													</option>
												<?php } ?>
											</select>
										</div>
									<?php } ?>
									<?php if ($option['type'] == 'radio') { ?>
										<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> <?php echo $option['style'] ?>">
											<label class="control-label"><?php echo $option['name']; ?></label>
											<div id="input-option<?php echo $option['product_option_id']; ?>">
												<?php foreach ($option['product_option_value'] as $option_value) { ?>
													<div class="radio">
														<label>
															<input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" points="<?php echo (isset($option_value['points_value']) ? $option_value['points_value'] : 0); ?>" price_prefix="<?php echo $option_value['price_prefix']; ?>" price="<?php echo $option_value['price_value']; ?>"/>
															<?php echo $option_value['name']; ?>
															<?php if ($option_value['price']) { ?>
																(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
															<?php } ?>
														</label>
													</div>
												<?php } ?>
											</div>
										</div>
									<?php } ?>
									<?php if ($option['type'] == 'checkbox') { ?>
										<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> <?php echo $option['style'] ?>">
											<label class="control-label"><?php echo $option['name']; ?></label>
											<div id="input-option<?php echo $option['product_option_id']; ?>">
												<?php foreach ($option['product_option_value'] as $option_value) { ?>
													<div class="checkbox">
														<label>
															<input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" points="<?php echo (isset($option_value['points_value']) ? $option_value['points_value'] : 0); ?>" price_prefix="<?php echo $option_value['price_prefix']; ?>" price="<?php echo $option_value['price_value']; ?>" />
															<?php echo $option_value['name']; ?>
															<?php if ($option_value['price']) { ?>
																(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
															<?php } ?>
														</label>
													</div>
												<?php } ?>
											</div>
										</div>
									<?php } ?>
									<?php if ($option['type'] == 'image') { ?>
										<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> <?php echo $option['style'] ?>">
											<label class="control-label"><?php echo $option['name']; ?></label>
											<div id="input-option<?php echo $option['product_option_id']; ?>">
												<?php foreach ($option['product_option_value'] as $option_value) { ?>
													<div class="radio">
														<label>
															<input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" points="<?php echo (isset($option_value['points_value']) ? $option_value['points_value'] : 0); ?>" price_prefix="<?php echo $option_value['price_prefix']; ?>" price="<?php echo $option_value['price_value']; ?>" data-img="<?php echo $option_value['product_option_image']; ?>" data-popup="<?php echo $option_value['product_option_image_popup']; ?>" class="img_class" />
															<img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /> <?php echo $option_value['name']; ?>
															<?php if ($option_value['price']) { ?>
																(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
															<?php } ?>
														</label>
													</div>
												<?php } ?>
											</div>
										</div>
									<?php } ?>
									<?php if ($option['type'] == 'text') { ?>
										<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> <?php echo $option['style'] ?>">
											<label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
											<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
										</div>
									<?php } ?>
									<?php if ($option['type'] == 'textarea') { ?>
										<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> <?php echo $option['style'] ?>">
											<label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
											<textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php echo $option['value']; ?></textarea>
										</div>
									<?php } ?>
									<?php if ($option['type'] == 'file') { ?>
										<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> <?php echo $option['style'] ?>">
											<label class="control-label"><?php echo $option['name']; ?></label>
											<button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default btn-block"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
											<input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>" />
										</div>
									<?php } ?>
									<?php if ($option['type'] == 'date') { ?>
										<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> <?php echo $option['style'] ?>">
											<label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
											<div class="input-group date">
												<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
												<span class="input-group-btn">
				<button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
				</span></div>
										</div>
									<?php } ?>
									<?php if ($option['type'] == 'datetime') { ?>
										<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> <?php echo $option['style'] ?>">
											<label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
											<div class="input-group datetime">
												<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
												<span class="input-group-btn">
				<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
				</span></div>
										</div>
									<?php } ?>
									<?php if ($option['type'] == 'time') { ?>
										<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> <?php echo $option['style'] ?>">
											<label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
											<div class="input-group time">
												<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
												<span class="input-group-btn">
				<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
				</span></div>
										</div>
									<?php } ?>
								<?php } ?>
							<?php } ?>
							<?php if ($recurrings) { ?>
								<hr>
								<h3><?php echo $text_payment_recurring ?></h3>
								<div class="form-group required">
									<select name="recurring_id" class="form-control">
										<option value=""><?php echo $text_select; ?></option>
										<?php foreach ($recurrings as $recurring) { ?>
											<option value="<?php echo $recurring['recurring_id'] ?>"><?php echo $recurring['name'] ?></option>
										<?php } ?>
									</select>
									<div class="help-block" id="recurring-description"></div>
								</div>
							<?php } ?>
							<div class="form-group">
								<label class="control-label" for="input-quantity"><?php echo $entry_qty; ?></label>
								<input type="text" name="quantity" value="<?php echo $minimum; ?>" size="2" id="input-quantity" class="form-control" />
								<input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
								<br />
								<button type="button" id="button-cart" data-product-id="<?php echo $product_id; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary btn-lg btn-block<?php echo ($in_cart) ? ' in_cart' : ''; ?>" data-title="<?php echo $heading_title ?>" data-target="#modal-cart"><span><?php echo $button_cart; ?></span></button>
							</div><div class="fastOrder">
								<input type="text" value="" name="phone" class="phone-input form-control" id="fast-order-phone" placeholder="+38 (0XX) XXX-XX-XX" />
								<input type="button" name="fb_phone" class="btn btn-primary" id="fast-order" value="Купить в 1 клик"/>
								<script>
									$('#fast-order-phone').mask('+38 (099) 999-99-99');
									$(document).ready(function(){
										$('#fast-order-phone').mask('+38 (099) 999-99-99');
									});
								</script>
								<script type="text/javascript"><!--
									var prd = <?php echo $product_id; ?>;
									$('#fast-order').on('click', function() {
										var phoneRequest = $('#fast-order-phone');
										if(phoneRequest.val() == ""){
											//alert("Заполните поле телефона")
											$('#fast-order-phone').css({'border-color':'red'})
										}else{
											$.ajax({
												url: '/index.php?route=product/product/fastBuyPhone',
												type: 'POST',
												data: {
													phone_fast: $('#fast-order-phone').val(),
													product_id: prd
												},
												dataType: 'text',
												beforeSend: function () {
													console.log('begin');
												},
												success: function () {
													$('#fast-order-phone').css({'border-color':'#d6d6d6'})
													$('#success-order').modal({show:true});
												}
											});
										}
									});
									//--></script>
							</div>
							<?php if ($minimum > 1) { ?>
								<div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $text_minimum; ?></div>
							<?php } ?>
						</div>
						<?php if ($review_status) { ?>
							<div class="rating">
								<p>
									<?php for ($i = 1; $i <= 5; $i++) { ?>
										<?php if ($rating < $i) { ?>
											<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
										<?php } else { ?>
											<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
										<?php } ?>
									<?php } ?>
									<a href="" onclick="$('a[href=\'#tab-review\']').trigger('click'); return false;"><?php echo $reviews; ?></a> / <a href="" onclick="$('a[href=\'#tab-review\']').trigger('click'); return false;"><?php echo $text_write; ?></a></p>
								<hr>
								<!-- AddThis Button BEGIN -->
								<div class="addthis_toolbox addthis_default_style"><a class="addthis_button_facebook_like" fb:like:layout="button_count"></a> <a class="addthis_button_tweet"></a> <a class="addthis_button_pinterest_pinit"></a> <a class="addthis_counter addthis_pill_style"></a></div>
								<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-515eeaf54693130e"></script>
								<!-- AddThis Button END -->
							</div>
						<?php } ?>
					</div>
				</div>
				<?php if ($products) { ?>
					<h3><?php echo $text_related; ?></h3>
					<div class="row">
						<?php $i = 0; ?>
						<?php foreach ($products as $product) { ?>
							<?php if ($column_left && $column_right) { ?>
								<?php $class = 'col-lg-6 col-md-6 col-sm-12 col-xs-12'; ?>
							<?php } elseif ($column_left || $column_right) { ?>
								<?php $class = 'col-lg-4 col-md-4 col-sm-6 col-xs-12'; ?>
							<?php } else { ?>
								<?php $class = 'col-lg-3 col-md-3 col-sm-6 col-xs-12'; ?>
							<?php } ?>
							<div class="<?php echo $class; ?>">
								<div class="product-thumb transition">
									<div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" /></a></div>
									<div class="caption">
										<h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
										<p><?php echo $product['description']; ?></p>
										<?php if ($product['rating']) { ?>
											<div class="rating">
												<?php for ($i = 1; $i <= 5; $i++) { ?>
													<?php if ($product['rating'] < $i) { ?>
														<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
													<?php } else { ?>
														<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
													<?php } ?>
												<?php } ?>
											</div>
										<?php } ?>
										<?php if ($product['price']) { ?>
											<p class="price">
												<?php if (!$product['special']) { ?>
													<?php echo $product['price']; ?>
												<?php } else { ?>
													<span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
												<?php } ?>
												<?php if ($product['tax']) { ?>
													<span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
												<?php } ?>
											</p>
										<?php } ?>
									</div>
									<div class="button-group">
										<button type="button" <?php if ( $product['quantity'] >= '1' ) { ?>onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');"<?php } ?>><span class="hidden-xs hidden-sm hidden-md"><?php echo $button_cart; ?></span> <i class="fa fa-shopping-cart"></i></button>
										<button type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart"></i></button>
										<button type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-exchange"></i></button>
									</div>
								</div>
							</div>
							<?php if (($column_left && $column_right) && ($i % 2 == 0)) { ?>
								<div class="clearfix visible-md visible-sm"></div>
							<?php } elseif (($column_left || $column_right) && ($i % 3 == 0)) { ?>
								<div class="clearfix visible-md"></div>
							<?php } elseif ($i % 4 == 0) { ?>
								<div class="clearfix visible-md"></div>
							<?php } ?>
							<?php $i++; ?>
						<?php } ?>
					</div>
				<?php } ?>
				<?php if ($tags) { ?>
					<p><?php echo $text_tags; ?>
						<?php for ($i = 0; $i < count($tags); $i++) { ?>
							<?php if ($i < (count($tags) - 1)) { ?>
								<a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
							<?php } else { ?>
								<a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
							<?php } ?>
						<?php } ?>
					</p>
				<?php } ?>
				<?php if (!$isXhr) { ?>
				<?php echo $content_bottom; ?>
			</div>
			<?php echo $column_right; ?>
		</div>
	</div>
	<script>
		$( document ).ready(function() {
			$( ".img_class" ).click(function() {
				var pathValid = $(this).attr('data-img');
				console.log(pathValid);
				if(pathValid === "") {
					console.log('no photo');
				}else{
					var pathToImg = $(this).attr('data-img');
					var pathToPopup = $(this).attr('data-popup');
					$('.img_main').attr("src", pathToImg);
					<?php if (!$isXhr) { ?>$('.img_main').attr("data-zoom-image", pathToPopup);<?php } ?>
					$('.img_main').parent().attr("href", pathToPopup);
				}
			});
		});
	</script>

	<script type="text/javascript">
		$('#review').delegate('.pagination a', 'click', function(e) {
			e.preventDefault();

			var _href = this.href;

			function complete() {
				$('#review').load(_href);

				$('#review').fadeIn('slow');
			}

			$('#review').fadeOut('fast', complete);
		});

		$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

		$('#button-review').on('click', function() {
			$.ajax({
				url: '/index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
				type: 'post',
				dataType: 'json',
				data: $("#form-review").serialize(),
				beforeSend: function() {
					$('#button-review').button('loading');
				},
				complete: function() {
					$('#button-review').button('reset');
				},
				success: function(json) {
					$('.alert-success, .alert-danger').remove();

					if (json['error']) {
						$('#review').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
					}

					if (json['success']) {
						$('#review').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');

						$('input[name=\'name\']').val('');
						$('textarea[name=\'text\']').val('');
						$('input[name=\'rating\']:checked').prop('checked', false);
					}
				}
			});
		});
	</script>

	<script type="text/javascript">
		$(document).on('click', 'a.gallery-element', function (event) {
			event = event || window.event;
			var target = event.target || event.srcElement,
				link = target.src ? target.parentNode : target,
				options = {index: link, event: event},
				links = document.querySelectorAll('a.gallery-element');
			blueimp.Gallery(links, options);

		});
	</script>

	<!-- The Gallery as lightbox dialog, should be a child element of the document body -->
	<div id="blueimp-gallery" class="blueimp-gallery blueimp-gallery-controls">
		<div class="slides"></div>
		<h3 class="title"></h3>
		<a class="prev">‹</a>
		<a class="next">›</a>
		<a class="close">×</a>
		<a class="play-pause"></a>
		<ol class="indicator"></ol>
	</div>

	<script type="text/javascript"><!--
		function price_format(n) {
			c = <?php echo (empty($currency['decimals']) ? "0" : $currency['decimals'] ); ?>;
			d = '<?php echo $currency['decimal_point']; ?>'; // decimal separator
			t = '<?php echo $currency['thousand_point']; ?>'; // thousands separator
			s_left = '<?php echo $currency['symbol_left']; ?>';
			s_right = '<?php echo $currency['symbol_right']; ?>';

			n = n * <?php echo $currency['value']; ?>;

			//sign = (n < 0) ? '-' : '';

			//extracting the absolute value of the integer part of the number and converting to string
			i = parseInt(n = Math.abs(n).toFixed(c)) + '';

			j = ((j = i.length) > 3) ? j % 3 : 0;
			return s_left + (j ? i.substr(0, j) + t : '') + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : '') + s_right;
		}

		function calculate_tax(price) {
			<?php // Process Tax Rates
			if (isset($tax_rates) && $tax) {
				foreach ($tax_rates as $tax_rate) {
					if ($tax_rate['type'] == 'F') {
						echo 'price += '.$tax_rate['rate'].';';
					} elseif ($tax_rate['type'] == 'P') {
						echo 'price += (price * '.$tax_rate['rate'].') / 100.0;';
					}
				}
			}
			?>
			return price;
		}

		function process_discounts(price, quantity) {
			<?php
			foreach ($dicounts_unf as $discount) {
				echo 'if ((quantity >= '.$discount['quantity'].') && ('.$discount['price'].' < price)) price = '.$discount['price'].';'."\n";
			}
			?>
			return price;
		}

		animate_delay = 20;

		main_price_final = calculate_tax(Number($('#formated_price').attr('price')));
		main_price_start = calculate_tax(Number($('#formated_price').attr('price')));
		main_step = 0;
		main_timeout_id = 0;

		function animateMainPrice_callback() {
			main_price_start += main_step;

			if ((main_step > 0) && (main_price_start > main_price_final)){
				main_price_start = main_price_final;
			} else if ((main_step < 0) && (main_price_start < main_price_final)) {
				main_price_start = main_price_final;
			} else if (main_step == 0) {
				main_price_start = main_price_final;
			}

			$('#formated_price').html( price_format(main_price_start) );

			if (main_price_start != main_price_final) {
				main_timeout_id = setTimeout(animateMainPrice_callback, animate_delay);
			}
		}

		function animateMainPrice(price) {
			main_price_start = main_price_final;
			main_price_final = price;
			main_step = (main_price_final - main_price_start) / 10;

			clearTimeout(main_timeout_id);
			main_timeout_id = setTimeout(animateMainPrice_callback, animate_delay);
		}


		<?php if ($special) { ?>
		special_price_final = calculate_tax(Number($('#formated_special').attr('price')));
		special_price_start = calculate_tax(Number($('#formated_special').attr('price')));
		special_step = 0;
		special_timeout_id = 0;

		function animateSpecialPrice_callback() {
			special_price_start += special_step;

			if ((special_step > 0) && (special_price_start > special_price_final)){
				special_price_start = special_price_final;
			} else if ((special_step < 0) && (special_price_start < special_price_final)) {
				special_price_start = special_price_final;
			} else if (special_step == 0) {
				special_price_start = special_price_final;
			}

			$('#formated_special').html( price_format(special_price_start) );

			if (special_price_start != special_price_final) {
				special_timeout_id = setTimeout(animateSpecialPrice_callback, animate_delay);
			}
		}

		function animateSpecialPrice(price) {
			special_price_start = special_price_final;
			special_price_final = price;
			special_step = (special_price_final - special_price_start) / 10;

			clearTimeout(special_timeout_id);
			special_timeout_id = setTimeout(animateSpecialPrice_callback, animate_delay);
		}
		<?php } ?>


		function recalculateprice() {
			var main_price = Number($('#formated_price').attr('price'));
			var input_quantity = Number($('input[name="quantity"]').val());
			var special = Number($('#formated_special').attr('price'));
			var tax = 0;

			if (isNaN(input_quantity)) input_quantity = 0;

			// Process Discounts.
			<?php if ($special) { ?>
			special = process_discounts(special, input_quantity);
			<?php } else { ?>
			main_price = process_discounts(main_price, input_quantity);
			<?php } ?>
			tax = process_discounts(tax, input_quantity);


			<?php if ($points) { ?>
			var points = Number($('#formated_points').attr('points'));
			$('input:checked,option:selected').each(function() {
				if ($(this).attr('points')) points += Number($(this).attr('points'));
			});
			$('#formated_points').html(Number(points));
			<?php } ?>

			var option_price = 0;

			$('input:checked,option:selected').each(function() {
				if ($(this).attr('price_prefix') == '=') {
					option_price += Number($(this).attr('price'));
					main_price = 0;
					special = 0;
				}
			});

			$('input:checked,option:selected').each(function() {
				if ($(this).attr('price_prefix') == '+') {
					option_price += Number($(this).attr('price'));
				}
				if ($(this).attr('price_prefix') == '-') {
					option_price -= Number($(this).attr('price'));
				}
				if ($(this).attr('price_prefix') == 'u') {
					pcnt = 1.0 + (Number($(this).attr('price')) / 100.0);
					option_price *= pcnt;
					main_price *= pcnt;
					special *= pcnt;
				}
				if ($(this).attr('price_prefix') == '*') {
					option_price *= Number($(this).attr('price'));
					main_price *= Number($(this).attr('price'));
					special *= Number($(this).attr('price'));
				}
			});

			special += option_price;
			main_price += option_price;

			<?php if ($special) { ?>
			tax = special;
			<?php } else { ?>
			tax = main_price;
			<?php } ?>

			// Process TAX.
			main_price = calculate_tax(main_price);
			special = calculate_tax(special);

			// Раскомментировать, если нужен вывод цены с умножением на количество
			main_price *= input_quantity;
			special *= input_quantity;
			tax *= input_quantity;

			// Display Main Price
			//$('#formated_price').html( price_format(main_price) );
			animateMainPrice(main_price);

			<?php if ($special) { ?>
			//$('#formated_special').html( price_format(special) );
			animateSpecialPrice(special);
			<?php } ?>

			<?php if ($tax) { ?>
			$('#formated_tax').html( price_format(tax) );
			<?php } ?>
		}

		$(document).ready(function() {
			$('input[type="checkbox"]').bind('change', function() { recalculateprice(); });
			$('input[type="radio"]').bind('change', function() { recalculateprice(); });
			$('select').bind('change', function() { recalculateprice(); });

			$quantity = $('input[name="quantity"]');
			$quantity.data('val', $quantity.val());
			(function() {
				if ($quantity.val() != $quantity.data('val')){
					$quantity.data('val',$quantity.val());
					recalculateprice();
				}
				setTimeout(arguments.callee, 250);
			})();

			recalculateprice();
		});
		//--></script>
	<?php echo $footer; ?>
<?php } ?>