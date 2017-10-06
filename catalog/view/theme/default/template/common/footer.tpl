<?php echo $content_footer; ?>
<footer>
	<ul class="list-social">
		<?php if ($config_vk) { ?><li class="vk"><a href="<?php echo $config_vk; ?>" rel="nofollow" target="_blank">Vk</a></li><?php } ?>
		<?php if ($config_instagram) { ?><li class="in"><a href="<?php echo $config_instagram; ?>" rel="nofollow" target="_blank">Instagram</a></li><?php } ?>
		<?php if ($config_twitter) { ?><li class="tw"><a href="<?php echo $config_twitter; ?>" rel="nofollow" target="_blank">Twitter</a></li><?php } ?>
		<?php if ($config_facebook) { ?><li class="fb"><a href="<?php echo $config_facebook; ?>" rel="nofollow" target="_blank">Facebook</a></li><?php } ?>
		<?php if ($config_vimeo) { ?><li class="vimeo"><a href="<?php echo $config_vimeo; ?>" rel="nofollow" target="_blank">Vimeo</a></li><?php } ?>
		<?php if ($config_google) { ?><li class="vimeo"><a href="<?php echo $config_google; ?>" rel="nofollow" target="_blank">Google+</a></li><?php } ?>
		<?php if ($config_odnoklassniki) { ?><li class="vimeo"><a href="<?php echo $config_odnoklassniki; ?>" rel="nofollow" target="_blank">Однокласники</a></li><?php } ?>
	</ul>
	<?php if ($categories) { ?>
		<div class="container">
			<nav id="menu" class="navbar">
				<div class="navbar-header"><span id="category" class="visible-xs">Категории</span>
					<button type="button" class="btn btn-navbar navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse"><i class="fa fa-bars"></i></button>
				</div>
				<div class="collapse navbar-collapse navbar-ex1-collapse">
					<ul class="nav navbar-nav">
						<?php foreach ($categories as $category) { ?>
							<?php if ($category['children']) { ?>
								<li class="dropdown"><a href="<?php echo $category['href']; ?>" class="dropdown-toggle" data-toggle="dropdown"><?php echo $category['name']; ?></a>
									<div class="dropdown-menu">
										<div class="dropdown-inner">
											<?php foreach (array_chunk($category['children'], ceil(count($category['children']) / $category['column'])) as $children) { ?>
												<ul class="list-unstyled">
													<?php foreach ($children as $child) { ?>
														<li><a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a></li>
													<?php } ?>
												</ul>
											<?php } ?>
										</div>
									</div>
								</li>
							<?php } else { ?>
								<li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
							<?php } ?>
						<?php } ?>
					</ul>
				</div>
			</nav>
		</div>
	<?php } ?>
	<div class="container">
		<div class="row">
			<?php if ($informations) { ?>
				<div class="col-sm-3">
					<h5><?php echo $text_information; ?></h5>
					<ul class="list-unstyled">
						<?php foreach ($informations as $information) { ?>
							<li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
						<?php } ?>
					</ul>
				</div>
			<?php } ?>
			<div class="col-sm-3">
				<h5><?php echo $text_service; ?></h5>
				<ul class="list-unstyled">
					<li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
					<li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
					<li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
				</ul>
			</div>
			<div class="col-sm-3">
				<h5><?php echo $text_extra; ?></h5>
				<ul class="list-unstyled">
					<li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
					<li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
					<li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
					<li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
				</ul>
			</div>
			<div class="col-sm-3">
				<h5><?php echo $text_account; ?></h5>
				<ul class="list-unstyled">
					<li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
					<li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
					<li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
					<li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
				</ul>
			</div>
		</div>
		<hr>
		<p><?php echo $powered; ?></p>
	</div>
</footer>
</div>
<?php echo $modals ?>
<p id="topon"><a href="#top"><span></span></a></p>
<script src="/catalog/view/javascript/app.js"></script>
</body>
</html>
