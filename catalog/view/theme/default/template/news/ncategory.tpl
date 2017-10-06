<h1><?php echo $heading_title; ?></h1>
<?php if ($description) { ?>
  <div class="category-info">
	  <div class="category-text">
		  <?php echo $description; ?>
	  </div>
  </div>
	<script>
		$( document ).ready(function() {
			var img_category = $('.category-info').find('img').attr('src');
			var img_category_height = $('.category-info').find('img').height();
			$('.category-info').find('img').parent().hide();
			$('.category-info').css({'background':'url("'+img_category+'") no-repeat 50% 0','height':img_category_height});
		});
	</script>
<?php } ?>

<div class="blog-category">
	<?php if ($article) { ?>
		<div class="row">
			<?php foreach ($article as $articles) { ?>
				<div class="col-xs-4 effect-apollo">
					<img class="article-image" align="left" src="<?php echo $articles['thumb']; ?>" title="<?php echo $articles['name']; ?>" alt="<?php echo $articles['name']; ?>" />
					<div class="item">
						<div><?php echo $articles['description']; ?></div>
						<h3><?php echo $articles['name']; ?></h3>
						<a href="<?php echo $articles['href']; ?>"><?php echo $button_more; ?></a>
					</div>
				</div>
			<?php } ?>
		</div>
		<?php if ($pagination) { ?><div class="row paginationBlock">
			<div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
			<div class="col-sm-6 text-right"><?php echo $pag_results; ?></div>
		</div><?php } ?>
	<?php } else { ?>
		<div class="c_error"><?php echo $text_empty; ?></div>
	<?php } ?>
</div>