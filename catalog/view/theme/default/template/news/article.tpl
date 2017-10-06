<div class="article-content">
	<div class="row">
		<?php if ($thumb) { ?><div class="image-col">
			<a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" class="gallery-element">
				<img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image-article" />
			</a>
		</div><?php } ?>
		<div class="<?php if ($thumb) { ?>description-col<?php } else { ?>description-col full<?php } ?>">
			<h1><?php echo $heading_title; ?></h1>
			<div class="descriptionBlock">
				<?php echo $description; ?>
			</div>
			<div class="descriptionMore">
				<a id="button-dt" onclick="return false;" href="javascript:void(0);" data-short-test="<?php echo $data_short; ?>" data-full-test="<?php echo $data_full; ?>"><span><?php echo $data_full; ?></span> <i class="fa fa-angle-down"></i></a>
			</div>
		</div>
	</div>
	<?php if ( $ncategory_id == '61' ) { ?><div class="other-project">
		<div class="title"><?php echo $button_other_project_text; ?></div>
		<a href="<?php echo $button_other_project_link; ?>" class="btn btn-primary"><?php echo $button_other_project; ?></a>
	</div><?php } else { ?><div class="other-project">
			<div class="title"><?php echo $button_other_services_text; ?></div>
			<a href="<?php echo $button_other_services_link; ?>" class="btn btn-primary"><?php echo $button_other_services; ?></a>
		</div><?php } ?>
	<?php if ($gallery_images) { ?><div class="row article-gallery">
		<?php $i=1; foreach ($gallery_images as $gallery) { ?>
			<a class="gallery-element" href="<?php echo $gallery['popup']; ?>" title="<?php if ( !empty($gallery['text']) ) { echo $gallery['text']; } else { echo $heading_title.' галерея фото #'.$i; } ?>">
				<img src="<?php echo $gallery['thumb']; ?>" alt="<?php if ( !empty($gallery['text']) ) { echo $gallery['text']; } else { echo $heading_title.' галерея фото #'.$i; } ?>" title="<?php if ( !empty($gallery['text']) ) { echo $gallery['text']; } else { echo $heading_title.' галерея фото #'.$i; } ?>" />
			</a>
		<?php $i++;} ?>
	</div><?php }?>
	<?php if ($article_videos) { ?>
		<div class="content blog-videos">
			<?php foreach ($article_videos as $video) { ?>
				<?php echo ($video['text']) ? '<h2 class="video-heading">'.$video['text'].'</h2>' : ''; ?>
				<div>
					<?php echo $video['code']; ?>
				</div>
			<?php } ?>
		</div>
	<?php } ?>
</div>


<?php if ($products) { ?>
<h3><?php echo $news_prelated; ?></h3>
<div class="row product-layout">
  <?php foreach ($products as $product) { ?>
  <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
    <div class="product-thumb transition">
      <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" /></a></div>
      <div class="caption">
        <h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
        <p><?php echo $product['description']; ?></p>
        <?php if ($product['rating']) { ?>
        <div class="rating">
          <?php for ($i = 1; $i <= 5; $i++) { ?>
          <?php if ($product['rating'] < $i) { ?>
          <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
          <?php } else { ?>
          <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
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
        <button type="button" onclick="cart.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $button_cart; ?></span></button>
        <button type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart"></i></button>
        <button type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-exchange"></i></button>
      </div>
    </div>
  </div>
  <?php } ?>
</div>
<?php } ?>
<?php if ($article) { ?>
<h2><?php echo $news_related; ?></h2>
  <div class="content blog-content">
	<div class="bnews-list<?php if (count($article)>1) { ?> bnews-list-2<?php } ?>">
		<?php foreach ($article as $articles) { ?>
			<div class="artblock<?php if (count($article)>1) { ?> artblock-2<?php } ?>">
				<?php if ($articles['name']) { ?>
					<div class="name"><a href="<?php echo $articles['href']; ?>"><?php echo $articles['name']; ?></a></div>
				<?php } ?>
				<div class="article-meta">
					<?php if ($articles['author']) { ?>
						<?php echo $text_posted_by; ?> <a href="<?php echo $articles['author_link']; ?>"><?php echo $articles['author']; ?></a> |
					<?php } ?>
					<?php if ($articles['date_added']) { ?>
						<?php if ($articles['author']) { ?><?php echo $text_posted_on; ?><?php } else { ?><?php echo $text_posted_pon; ?><?php } ?> <?php echo $articles['date_added']; ?> |
					<?php } ?>
					<?php if ($articles['du']) { ?>
						<?php echo $text_updated_on; ?> <?php echo $articles['du']; ?> |
					<?php } ?>
					<?php if ($articles['category']) { ?>
						<?php echo $text_posted_in; ?> <?php echo $articles['category']; ?> |
					<?php } ?>
				</div>
				<?php if ($articles['thumb']) { ?>
					<a href="<?php echo $articles['href']; ?>"><img class="article-image" align="left" src="<?php echo $articles['thumb']; ?>" title="<?php echo $articles['name']; ?>" alt="<?php echo $articles['name']; ?>" /></a>
				<?php } ?>
				<?php if ($articles['custom1']) { ?>
					<div class="custom1"><?php echo $articles['custom1']; ?></div>
				<?php } ?>
				<?php if ($articles['custom2']) { ?>
					<div class="custom2"><?php echo $articles['custom2']; ?></div>
				<?php } ?>
				<?php if ($articles['custom3']) { ?>
					<div class="custom3"><?php echo $articles['custom3']; ?></div>
				<?php } ?>
				<?php if ($articles['custom4']) { ?>
					<div class="custom4"><?php echo $articles['custom4']; ?></div>
				<?php } ?>
				<?php if ($articles['description']) { ?>
					<div class="description"><?php echo $articles['description']; ?></div>
				<?php } ?>
				<?php if ($articles['total_comments']) { ?>
				  <?php if (!$disqus_status && !$fbcom_status) { ?>
					<div class="total-comments"><?php echo $articles['total_comments']; ?> <?php echo $text_comments; ?> - <a href="<?php echo $articles['href']; ?>#comments"><?php echo $text_comments_v; ?></a></div>
				  <?php } elseif ($fbcom_status) { ?>
					<div class="total-comments"><fb:comments-count href="<?php echo $articles['href']; ?>"></fb:comments-count> <?php echo $text_comments; ?> - <a href="<?php echo $articles['href']; ?>#comments"><?php echo $text_comments_v; ?></a></div>
				  <?php } else { ?>
					<div class="total-comments"><a data-disqus-identifier="article_<?php echo $articles['article_id']; ?>" href="<?php echo $articles['href']; ?>#disqus_thread"><?php echo $text_comments_v; ?></a></div>
				  <?php } ?>
				<?php } ?>
				<?php if ($articles['button']) { ?>
					<div class="blog-button"><a class="button" href="<?php echo $articles['href']; ?>"><?php echo $button_more; ?></a></div>
				<?php } ?>
			</div>
		<?php } ?>
	</div>
  </div>
<?php } ?>