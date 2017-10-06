<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-flyoutmenu" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
<script type="text/javascript" src="view/cpicker/jquery.miniColors.js"></script>
<link rel="stylesheet" type="text/css" href="view/cpicker/jquery.miniColors.css" />
<link rel="stylesheet" type="text/css" href="view/cpicker/flyoutmenu.css" />
<script type="text/javascript">
			function startColMan() {
			$(".colors").miniColors({ change: function(hex, rgb) { $("#console").prepend('HEX: ' + hex + ' (RGB: ' + rgb.r + ', ' + rgb.g + ', ' + rgb.b + ')<br />'); } }); }
			$(document).ready(startColMan);
			
</script>
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $heading_title; ?></h3>
      </div>
	  <?php $this->model('tool/image'); ?>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-flyoutmenu" class="form-horizontal">
		<div class="active_menu">
			<?php echo $text_editting_menu; ?>  
			<?php if ($current_menu) { ?>
				<strong><?php echo (isset($flyoutmenu_mobilemenuname[$active_language]) && $flyoutmenu_mobilemenuname[$active_language]) ? $flyoutmenu_mobilemenuname[$active_language] : 'Menu '.$current_menu; ?></strong>
			<?php } else { ?>
				<strong><?php echo $text_default_menu; ?></strong>
			<?php } ?>
			<?php echo $text_selectedit_menu; ?>
			<select class="allmenus form-control" onchange="location = this.value;">
				<option disabled="disabled" selected="selected"><?php echo $text_selectedit_menu; ?></option>
				<option value="<?php echo $default_url; ?>" > <?php echo $text_default_menu; ?></option>
				<?php foreach ($flyoutmenu_menus as $menu) { ?>
					<option value="<?php echo $menu['url']; ?>" ><?php echo $menu['name']; ?></option>
				<?php } ?>
			</select>
			<input type="hidden" name="<?php echo $preffix; ?>flyoutmenu_menu_id" value="<?php echo $current_menu; ?>" />
			<a href="<?php echo $default_url; ?>&menu_id=<?php echo $newmenu; ?>" class="btn btn-success"><?php echo $text_new_menu; ?></a>
			<?php if ($delete_url) { ?>
				<a href="<?php echo $delete_url; ?>" onclick="if (!confirm('<?php echo $text_delete_confirm; ?>')) { return false; }" class="btn btn-warning"><?php echo $text_delete_menu; ?></a>
				
			<?php } ?>
		</div>
			<ul class="nav nav-tabs">
				<li class="active"><a href="#tab-items" data-toggle="tab"><?php echo $tab_items; ?></a></li>
				<li><a href="#tab-settings" data-toggle="tab"><?php echo $tab_settings; ?></a></li>
				<li><a href="#tab-html" data-toggle="tab"><?php echo $tab_html; ?></a></li>
            </ul>
<div class="tab-content">
<div class="tab-pane active in" id="tab-items">
	<div class="table-responsive">
        <table id="item" class="table table-striped table-bordered table-hover">
          <thead>
            <tr>
              <td class="text-left"><?php echo $entry_type; ?></td>
              <td style="width: 46%;" class="text-left"><?php echo $entry_iset; ?></td>
              <td class="text-left"><?php echo $entry_advanced; ?></td>
              <td>Поцизия</td>
              <td></td>
            </tr>
          </thead>
          <?php $item_row = 0; ?>
		  <?php $libg = '#fcfcfc'; ?>
          <?php foreach ($items as $item) { ?>
		  <?php $libg = ($libg == '#fff' ? '#fcfcfc' : '#fff'); ?>
              <tbody class="item-row" id="item-row<?php echo $item_row; ?>">
              <tr>
                  <td class="text-left" style="background: <?php echo $libg; ?>;">
		   <select class="item-type form-control" id="item-type<?php echo $item_row; ?>" name="<?php echo $preffix; ?>flyoutmenu_item[<?php echo $item_row; ?>][type]">
			      <?php if ($item['type'] == 'cat') { ?>
                  <option class="ocat" id="ocat<?php echo $item_row; ?>" value="cat" selected="selected"><?php echo $type_cat; ?></option>
                  <?php } else { ?>
                  <option class="ocat" id="ocat<?php echo $item_row; ?>" value="cat"><?php echo $type_cat; ?></option>
                  <?php } ?>
				  <?php if ($item['type'] == 'infol') { ?>
                  <option class="oinfol" id="oinfol<?php echo $item_row; ?>" value="infol" selected="selected"><?php echo $type_infol; ?></option>
                  <?php } else { ?>
                  <option class="oinfol" id="oinfol<?php echo $item_row; ?>" value="infol"><?php echo $type_infol; ?></option>
                  <?php } ?>
				  <?php if ($item['type'] == 'infod') { ?>
                  <option value="infod" selected="selected"><?php echo $type_infod; ?></option>
                  <?php } else { ?>
                  <option value="infod"><?php echo $type_infod; ?></option>
                  <?php } ?>
				   <?php if ($item['type'] == 'custom') { ?>
                  <option class="ocustom" id="ocustom<?php echo $item_row; ?>" value="custom" selected="selected"><?php echo $type_custom; ?></option>
                  <?php } else { ?>
                  <option class="ocustom" id="ocustom<?php echo $item_row; ?>" value="custom"><?php echo $type_custom; ?></option>
                  <?php } ?>
				  <?php if ($item['type'] == 'mand') { ?>
                  <option class="mand" id="mand<?php echo $item_row; ?>" value="mand" selected="selected"><?php echo $type_mand; ?></option>
                  <?php } else { ?>
                  <option class="mand" id="mand<?php echo $item_row; ?>" value="mand"><?php echo $type_mand; ?></option>
                  <?php } ?>
				   <?php if ($item['type'] == 'more') { ?>
                  <option class="more" id="more<?php echo $item_row; ?>" value="more" selected="selected"><?php echo $type_more; ?></option>
                  <?php } else { ?>
                  <option class="more" id="more<?php echo $item_row; ?>" value="more"><?php echo $type_more; ?></option>
                  <?php } ?>
				   <?php if ($item['type'] == 'more2') { ?>
                  <option class="moredoi" id="moredoi<?php echo $item_row; ?>" value="more2" selected="selected"><?php echo $type_more2; ?></option>
                  <?php } else { ?>
                  <option class="moredoi" id="moredoi<?php echo $item_row; ?>" value="more2"><?php echo $type_more2; ?></option>
                  <?php } ?>
				  <?php if ($item['type'] == 'products') { ?>
                  <option class="oproducts" id="oproducts<?php echo $item_row; ?>" value="products" selected="selected"><?php echo $type_products; ?></option>
                  <?php } else { ?>
                  <option class="oproducts" id="oproducts<?php echo $item_row; ?>" value="products"><?php echo $type_products; ?></option>
                  <?php } ?>
				   <?php if ($item['type'] == 'catprods') { ?>
                  <option class="catprods" id="catprods<?php echo $item_row; ?>" value="catprods" selected="selected"><?php echo $type_catprods; ?></option>
                  <?php } else { ?>
                  <option class="catprods" id="catprods<?php echo $item_row; ?>" value="catprods"><?php echo $type_catprods; ?></option>
                  <?php } ?>
				   <?php if ($item['type'] == 'login') { ?>
                  <option class="login" id="login<?php echo $item_row; ?>" value="login" selected="selected"><?php echo $type_login; ?></option>
                  <?php } else { ?>
                  <option class="login" id="login<?php echo $item_row; ?>" value="login"><?php echo $type_login; ?></option>
                  <?php } ?>
		 </select>
		 <div class="viewsel viewsel<?php echo $item_row; ?>"><b><?php echo $text_sview; ?> </b>
		  <select name="<?php echo $preffix;  ?>flyoutmenu_item[<?php echo $item_row; ?>][view]" class="form-control">
			      <?php if (!$item['view']) { ?>
                  <option value="0" selected="selected"><?php echo $text_slist; ?></option>
                  <?php } else { ?>
				  <option value="0"><?php echo $text_slist; ?></option>
                  <?php } ?>
				  <?php if ($item['view'] == '1') { ?>
                  <option value="1" selected="selected"><?php echo $text_sgrid; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_sgrid; ?></option>
                  <?php } ?>
				  <?php if ($item['view'] == 'f0') { ?>
                  <option value="f0" selected="selected"><?php echo $text_dflist; ?></option>
                  <?php } else { ?>
                  <option value="f0"><?php echo $text_dflist; ?></option>
                  <?php } ?>
				  <?php if ($item['view'] == 'f1') { ?>
                  <option value="f1" selected="selected"><?php echo $text_dfgrid; ?></option>
                  <?php } else { ?>
                  <option value="f1"><?php echo $text_dfgrid; ?></option>
                  <?php } ?>
		  </select>
		  </div>
		 </td>
                  <td class="text-left" style="background: <?php echo $libg; ?>;">
		  <div style="position: relative">

		  <div id="cat-type<?php echo $item_row; ?>" class="typediv cat-type">
		  <h3 class="superh3"><?php echo $entry_category; ?></h3>
		  <select style="width: 310px;" name="<?php echo $preffix;  ?>flyoutmenu_item[<?php echo $item_row; ?>][category_id]" class="form-control">
		          <?php foreach ($categories as $category ){ ?>
		          <?php if ($category['category_id'] == $item['category_id']) { ?>
		          <option value="<?php echo $category['category_id']; ?>" selected="selected"><?php echo $category['name'] ?></option>
		          <?php } else { ?>
                  <option value="<?php echo $category['category_id']; ?>"><?php echo $category['name'] ?></option>
                  <?php } ?>
                  <?php } ?>
          </select>
              <hr />
		 </div>
		  <div id="info-type<?php echo $item_row; ?>" class="typediv info-type">
		 <h3 class="superh3"><?php echo $entry_information; ?></h3>
		  <select style="width: 310px;" name="<?php echo $preffix;  ?>flyoutmenu_item[<?php echo $item_row; ?>][information_id]" class="form-control">
		          <?php foreach ($informations as $information){ ?>
		          <?php if ($information['information_id'] == $item['information_id']) { ?>
		          <option value="<?php echo $information['information_id']; ?>" selected="selected"><?php echo $information['name'] ?></option>
		          <?php } else { ?>
                  <option value="<?php echo $information['information_id']; ?>"><?php echo $information['name'] ?></option>
                  <?php } ?>
                  <?php } ?>
          </select><hr />
		  </div>

          <div id="oproducts-type<?php echo $item_row; ?>" class="typediv oproducts-type">
			<h3 class="superh3"><?php echo $text_whatproducts; ?></h3>
			<?php if (!isset($item['products'])) { $item['products'] = ''; } ?>
			<select style="width: 310px;" name="<?php echo $preffix;  ?>flyoutmenu_item[<?php echo $item_row; ?>][products]">
		          <?php if ($item['products'] == 'latest') { ?>
                  <option  value="latest" selected="selected"><?php echo $text_productlatest; ?></option>
                  <?php } else { ?>
                  <option value="latest"><?php echo $text_productlatest; ?></option>
                  <?php } ?>
				  <?php if ($item['products'] == 'special') { ?>
                  <option  value="special" selected="selected"><?php echo $text_productspecial; ?></option>
                  <?php } else { ?>
                  <option value="special"><?php echo $text_productspecial; ?></option>
                  <?php } ?>
				  <?php if ($item['products'] == 'featured') { ?>
                  <option  value="featured" selected="selected"><?php echo $text_productfeatured; ?></option>
                  <?php } else { ?>
                  <option value="featured"><?php echo $text_productfeatured; ?></option>
                  <?php } ?>
				  <?php if ($item['products'] == 'bestseller') { ?>
                  <option  value="bestseller" selected="selected"><?php echo $text_productbestseller; ?></option>
                  <?php } else { ?>
                  <option value="bestseller"><?php echo $text_productbestseller; ?></option>
                  <?php } ?>
            </select><hr />
		  </div>

		  <div id="productlimit-type<?php echo $item_row; ?>" class="typediv productlimit-type">
		   <?php echo $text_productlimit; ?> <input size="1" type="text" name="<?php echo $preffix;  ?>flyoutmenu_item[<?php echo $item_row; ?>][productlimit]" value="<?php echo isset($item['productlimit']) ? $item['productlimit'] : '5'; ?>" />
		  </div>


		  <div id="custom-type<?php echo $item_row; ?>" class="typediv custom-type">
		  <h3 class="superh3"><?php echo $entry_custom; ?></h3>
			<?php foreach ($languages as $language) { ?>
              <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $custom_name; ?>
			  <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_item[<?php echo $item_row; ?>][customname][<?php echo $language['language_id']; ?>]" value="<?php echo isset($item['customname'][$language['language_id']]) ? $item['customname'][$language['language_id']] : ''; ?>" /><br /><br />
			  <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $custom_url; ?>
			  <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_item[<?php echo $item_row; ?>][customurl][<?php echo $language['language_id']; ?>]" value="<?php echo isset($item['customurl'][$language['language_id']]) ? $item['customurl'][$language['language_id']] : ''; ?>" /><br /><br />
            <?php } ?>
		  </div>


		   <h3 class="addsuperh3" id="hideadd-type<?php echo $item_row; ?>"><?php echo $entry_add; ?></h3>
		   <div id="add-type<?php echo $item_row; ?>" class="addtypediv">
			  <?php foreach ($languages as $language) { ?>
			  <div style="padding: 3px; background: #eee; border: 1px solid #ddd; margin-bottom: 2px; text-align: left; font-weight: bold;"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
			 URL: <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_item[<?php echo $item_row; ?>][addurl][<?php echo $language['language_id']; ?>]" value="<?php echo isset($item['addurl'][$language['language_id']]) ? $item['addurl'][$language['language_id']] : ''; ?>" />
				<div>
					<a href="" id="thumb-image_<?php echo $item_row; ?><?php echo $language['language_id']; ?>" data-toggle="image" class="img-thumbnail">
						<img style="max-width: 200px" src="<?php if ($item['image'][$language['language_id']] && strlen($item['image'][$language['language_id']]) > 3) { ?><?php echo HTTP_CATALOG . "image/" . $item['image'][$language['language_id']]; ?><?php } else { ?><?php echo $no_image; ?><?php } ?>" alt="" title="" data-placeholder="<?php echo $no_image; ?>" />
					</a>
					<input type="hidden" name="<?php echo $preffix;  ?>flyoutmenu_item[<?php echo $item_row; ?>][image][<?php echo $language['language_id']; ?>]" value="<?php echo $item['image'][$language['language_id']]; ?>" id="input-image_<?php echo $item_row; ?><?php echo $language['language_id']; ?>" />
				</div>
				</div>
			  <?php } ?>
			  </div>
			  </div>
			  </td>
                  <td class="text-left" style="background: <?php echo $libg; ?>;">
			  <style type="text/css">
			  .advm<?php echo $item_row; ?> .advh {
			     display:none;
			  }
			  </style>
			  <div class="advm<?php echo $item_row; ?> advs">
			  <a class="expand"><?php echo $text_expando; ?></a>
			  <div class="advh">
			  <a class="closeadvm"><strong><span style="font-size:20px;"><span style="font-family:lucida sans unicode,lucida grande,sans-serif;">x</span></span></strong></a>
			  <table class="table table-striped table-bordered table-hover smenua">
			  <tr><td><?php echo $text_tlcolor; ?></td>
			  <td><input class="form-control" type="text" name="<?php echo $preffix;  ?>flyoutmenu_item[<?php echo $item_row; ?>][tlcolor]" class="colors" value="<?php echo isset($item['tlcolor']) ? $item['tlcolor'] : ''; ?>" size="7" /></td>
			  <td><?php echo $text_tlstyle; ?></td>
			  <td><input class="form-control" type="text" name="<?php echo $preffix;  ?>flyoutmenu_item[<?php echo $item_row; ?>][tlstyle]" value="<?php echo isset($item['tlstyle']) ? $item['tlstyle'] : ''; ?>" size="28" /></td>
			  </tr>
			  <tr>
			  <td><?php echo $text_chtml; ?></td>
			  <td><select name="<?php echo $preffix;  ?>flyoutmenu_item[<?php echo $item_row; ?>][chtml]" class="form-control">
			      <?php if (!$item['chtml']) { ?>
                  <option value="0" selected="selected"><?php echo $text_no; ?></option>
				  <option value="1"><?php echo $text_alldrop; ?></option>
				  <option value="2"><?php echo $text_justadd; ?></option>
				  <option value="3"><?php echo $text_overdrop; ?></option>
                  <?php } elseif ($item['chtml'] == 1) { ?>
                  <option value="1"  selected="selected"><?php echo $text_alldrop; ?></option>
				  <option value="3"><?php echo $text_overdrop; ?></option>
				  <option value="2"><?php echo $text_justadd; ?></option>
				  <option value="0"><?php echo $text_no; ?></option>
				  <?php } elseif ($item['chtml'] == 3) { ?>
                  <option value="0"><?php echo $text_no; ?></option>
				  <option value="1"><?php echo $text_alldrop; ?></option>
				  <option value="3" selected="selected"><?php echo $text_overdrop; ?></option>
				  <option value="2"><?php echo $text_justadd; ?></option>
				  <?php } else { ?>
                  <option value="1"><?php echo $text_alldrop; ?></option>
				  <option value="3"><?php echo $text_overdrop; ?></option>
				  <option value="2"  selected="selected"><?php echo $text_justadd; ?></option>
				  <option value="0"><?php echo $text_no; ?></option>
                  <?php } ?>
			   </select>
			   <select class="form-control" name="<?php echo $preffix;  ?>flyoutmenu_item[<?php echo $item_row; ?>][cchtml]">
			      <?php if ($item['cchtml'] == 'area1') { ?>
                  <option value="area1" selected="selected">Area 1</option>
                  <?php } else { ?>
                  <option value="area1">Area 1</option>
                  <?php } ?>
				  <?php if ($item['cchtml'] == 'area2') { ?>
                  <option value="area2" selected="selected">Area 2</option>
                  <?php } else { ?>
                  <option value="area2">Area 2</option>
                  <?php } ?>
				  <?php if ($item['cchtml'] == 'area3') { ?>
                  <option value="area3" selected="selected">Area 3</option>
                  <?php } else { ?>
                  <option value="area3">Area 3</option>
                  <?php } ?>
				  <?php if ($item['cchtml'] == 'area4') { ?>
                  <option value="area4" selected="selected">Area 4</option>
                  <?php } else { ?>
                  <option value="area4">Area 4</option>
                  <?php } ?>
				  <?php if ($item['cchtml'] == 'area5') { ?>
                  <option value="area5" selected="selected">Area 5</option>
                  <?php } else { ?>
                  <option value="area5">Area 5</option>
                  <?php } ?>
				  <?php if ($item['cchtml'] == 'area6') { ?>
                  <option value="area6" selected="selected">Area 6</option>
                  <?php } else { ?>
                  <option value="area6">Area 6</option>
                  <?php } ?>
				  <?php if ($item['cchtml'] == 'area7') { ?>
                  <option value="area7" selected="selected">Area 7</option>
                  <?php } else { ?>
                  <option value="area7">Area 7</option>
                  <?php } ?>
				  <?php if ($item['cchtml'] == 'area8') { ?>
                  <option value="area8" selected="selected">Area 8</option>
                  <?php } else { ?>
                  <option value="area8">Area 8</option>
                  <?php } ?>
			   </select>
			  </td>
	          <td><?php echo $text_subcatdisplay; ?></td>
			  <?php if (!isset($item['subcatdisplay'])) { $item['subcatdisplay'] = ''; } ?>
			  <td><select class="form-control" name="<?php echo $preffix;  ?>flyoutmenu_item[<?php echo $item_row; ?>][subcatdisplay]">
			       <?php if ($item['subcatdisplay'] == 'all') { ?>
                    <option value="all" selected="selected"><?php echo $text_subcatdisplay_all; ?></option>
                   <?php } else { ?>
                    <option value="all"><?php echo $text_subcatdisplay_all; ?></option>
                   <?php } ?>
			       <?php if ($item['subcatdisplay'] == 'level1') { ?>
                    <option value="level1" selected="selected"><?php echo $text_subcatdisplay_level1; ?></option>
                   <?php } else { ?>
                    <option value="level1"><?php echo $text_subcatdisplay_level1; ?></option>
                   <?php } ?>
			       <?php if ($item['subcatdisplay'] == 'none') { ?>
                    <option value="none" selected="selected"><?php echo $text_subcatdisplay_none; ?></option>
                   <?php } else { ?>
                    <option value="none"><?php echo $text_subcatdisplay_none; ?></option>
                   <?php } ?>
				  </select</td>
			   </tr><tr>
			   <td><?php echo $text_dwidth; ?></td>
		      <td><input class="form-control" size="3" type="text" name="<?php echo $preffix;  ?>flyoutmenu_item[<?php echo $item_row; ?>][dwidth]" value="<?php echo isset($item['dwidth']) ? $item['dwidth'] : ''; ?>" /></td>
			  <td> <?php echo $text_iwidth; ?></td>
			  <td><input class="form-control" size="3" type="text" name="<?php echo $preffix;  ?>flyoutmenu_item[<?php echo $item_row; ?>][iwidth]" value="<?php echo isset($item['iwidth']) ? $item['iwidth'] : ''; ?>" /></td></tr>
			  <tr>
			  <td><?php echo $text_stores; ?></td>
			  <td>
			  <div class="scrollbox" style=" width: 180px; height: 60px;">
                  <?php $sbclass = 'even'; ?>
                  <div class="<?php echo $sbclass; ?>">
				  <?php if (isset($item['stores'])) { ?>
                    <?php if (in_array(0, $item['stores'])) { ?>
                    <input type="checkbox" name="<?php echo $preffix;  ?>flyoutmenu_item[<?php echo $item_row; ?>][stores][]" value="0" checked="checked" />
                    <?php echo $text_default; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="<?php echo $preffix;  ?>flyoutmenu_item[<?php echo $item_row; ?>][stores][]" value="0" />
                    <?php echo $text_default; ?>
                    <?php } ?>
				   <?php } else { ?>
				    <input type="checkbox" name="<?php echo $preffix;  ?>flyoutmenu_item[<?php echo $item_row; ?>][stores][]" value="0" />
                    <?php echo $text_default; ?>
				   <?php } ?>
                  </div>
                  <?php foreach ($stores as $store) { ?>
                  <?php $sbclass = ($sbclass == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $sbclass; ?>">
				  <?php if (isset($item['stores'])) { ?>
                    <?php if (in_array($store['store_id'], $item['stores'])) { ?>
                    <input type="checkbox" name="<?php echo $preffix;  ?>flyoutmenu_item[<?php echo $item_row; ?>][stores][]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                    <?php echo $store['name']; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="<?php echo $preffix;  ?>flyoutmenu_item[<?php echo $item_row; ?>][stores][]" value="<?php echo $store['store_id']; ?>" />
                    <?php echo $store['name']; ?>
                    <?php } ?>
				   <?php } else { ?>
                    <input type="checkbox" name="<?php echo $preffix;  ?>flyoutmenu_item[<?php echo $item_row; ?>][stores][]" value="<?php echo $store['store_id']; ?>" />
                    <?php echo $store['name']; ?>
				   <?php } ?>
                  </div>
                  <?php } ?>
                </div>
			  </td>
			  <td><?php echo $text_fbrands; ?></td>
			  <td><input class="form-control" size="28" type="text" name="<?php echo $preffix;  ?>flyoutmenu_item[<?php echo $item_row; ?>][fbrands]" value="<?php echo isset($item['fbrands']) ? $item['fbrands'] : ''; ?>" /></td>
			  </tr>
			  </table>
			  </div></div>
			  </td>
                  <td>
                      <input class="form-control" size="2" type="text" name="<?php echo $preffix;  ?>flyoutmenu_item[<?php echo $item_row; ?>][sorder]" value="<?php echo isset($item['sorder']) ? $item['sorder'] : ''; ?>" />
                  </td>
                  <td class="text-left" style="background: <?php echo $libg; ?>;">
				  <button type="button" onclick="$('#item-row<?php echo $item_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button>
			  </td>
              </tr>
              </tbody>
              <?php $item_row++; ?>
          <?php } ?>
            <tfoot>
            <tr>
                <td colspan="3"></td>
                <td class="text-left">
                    <button type="button" onclick="additem();" data-toggle="tooltip" title="<?php echo $button_add_item; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button>
                </td>
            </tr>
            </tfoot>
        </table>
	</div></div>
<div class="tab-pane" id="tab-settings">
		<div class="row">
		<div class="col-sm-5 col-xs-12" >
		<h2 class="h2settings"><?php echo $text_general; ?></h2>
		<div class="settings-row">
		<?php echo $text_settings_dropdowntitle; ?>&nbsp;
		<?php if ($flyoutmenu_dropdowntitle) { ?>
                <input type="radio" name="<?php echo $preffix;  ?>flyoutmenu_options[dropdowntitle]" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="<?php echo $preffix;  ?>flyoutmenu_options[dropdowntitle]" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="<?php echo $preffix;  ?>flyoutmenu_options[dropdowntitle]" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="<?php echo $preffix;  ?>flyoutmenu_options[dropdowntitle]" value="0" checked="checked" />
                <?php echo $text_no; ?>
        <?php } ?>
		</div>
		<div class="settings-row">
		<?php echo $text_settings_topitemlink; ?>&nbsp;
		<select name="<?php echo $preffix;  ?>flyoutmenu_options[topitemlink]">
			      <?php if ($flyoutmenu_topitemlink == 'bottom') { ?>
                  <option value="bottom" selected="selected">"View all" button in flyout</option>
                  <?php } else { ?>
                  <option value="bottom">"View all" button in flyout</option>
                  <?php } ?>
				  <?php if ($flyoutmenu_topitemlink == 'topitem') { ?>
                  <option value="topitem" selected="selected">Top item has link</option>
                  <?php } else { ?>
                  <option value="topitem">Main item has link</option>
                  <?php } ?>
				  <?php if ($flyoutmenu_topitemlink == 'heading') { ?>
                  <option value="heading" selected="selected">The flyout title has link</option>
                  <?php } else { ?>
                  <option value="heading">The flyout title has link</option>
                  <?php } ?>
		</select>
		</div>
		<div class="settings-row">
		<?php echo $text_settings_flyoutwidth; ?>&nbsp;
		<input type="text" name="<?php echo $preffix;  ?>flyoutmenu_options[flyout_width]" value="<?php echo $flyoutmenu_flyout_width; ?>" size="3" />px
		</div>
		<div class="settings-row">
		<?php echo $text_settings_flyoutcache; ?>&nbsp;
		<?php if ($flyoutmenu_flyoutcache) { ?>
                <input type="radio" name="<?php echo $preffix;  ?>flyoutmenu_options[flyoutcache]" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="<?php echo $preffix;  ?>flyoutmenu_options[flyoutcache]" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="<?php echo $preffix;  ?>flyoutmenu_options[flyoutcache]" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="<?php echo $preffix;  ?>flyoutmenu_options[flyoutcache]" value="0" checked="checked" />
                <?php echo $text_no; ?>
        <?php } ?>
		</div>
		<div class="settings-row">
		<?php echo $text_settings_bspacewidth; ?>&nbsp;
		<input type="text" name="<?php echo $preffix;  ?>flyoutmenu_options[bannerspace_width]" value="<?php echo $flyoutmenu_bannerspace_width; ?>" size="3" />px
		</div>
		<div class="settings-row">
		<?php echo $text_3dlevellimit; ?>&nbsp;
		<input type="text" name="<?php echo $preffix;  ?>flyoutmenu_options[3dlevellimit]" value="<?php echo $flyoutmenu_3dlevellimit; ?>" size="3" />
		</div>
		<div class="settings-row">
		<?php echo $entry_image_size; ?>&nbsp;  <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_options[image_width]" value="<?php echo $flyoutmenu_image_width; ?>" size="3" />px <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_options[image_height]" value="<?php echo $flyoutmenu_image_height; ?>" size="3" />px
		</div>
		<div class="settings-row">
		<?php echo $text_settings_dropeffect; ?>&nbsp;
		<select name="<?php echo $preffix;  ?>flyoutmenu_options[dropdowneffect]">
			      <?php if ($flyoutmenu_dropdowneffect == 'drop') { ?>
                  <option value="drop" selected="selected">Slide left</option>
                  <?php } else { ?>
                  <option value="drop">Slide left</option>
                  <?php } ?>
				  <?php if ($flyoutmenu_dropdowneffect == 'fade') { ?>
                  <option value="fade" selected="selected">Fade In</option>
                  <?php } else { ?>
                  <option value="fade">Fade In</option>
                  <?php } ?>
				  <?php if ($flyoutmenu_dropdowneffect == 'show') { ?>
                  <option value="show" selected="selected">Just show</option>
                  <?php } else { ?>
                  <option value="show">Just show</option>
                  <?php } ?>
		</select>
		</div>
		<div class="settings-row">
		<?php echo $text_settings_hoverintent; ?>&nbsp;
		<?php if ($flyoutmenu_usehoverintent) { ?>
                <input type="radio" name="<?php echo $preffix;  ?>flyoutmenu_options[usehoverintent]" value="1" checked="checked" />
                <?php echo $text_no; ?>
                <input type="radio" name="<?php echo $preffix;  ?>flyoutmenu_options[usehoverintent]" value="0" />
                <?php echo $text_yes; ?>
                <?php } else { ?>
                <input type="radio" name="<?php echo $preffix;  ?>flyoutmenu_options[usehoverintent]" value="1" />
                <?php echo $text_no; ?>
                <input type="radio" name="<?php echo $preffix;  ?>flyoutmenu_options[usehoverintent]" value="0" checked="checked" />
                <?php echo $text_yes; ?>
        <?php } ?>
		</div>
		<div class="settings-row">
		<?php echo $text_flyout_position; ?>&nbsp;
		<select name="<?php echo $preffix;  ?>flyoutmenu_options[positioning]">
			  <?php if ($flyoutmenu_positioning == 1) { ?>
                  <option value="1" selected="selected"><?php echo $text_flyout_position_ul; ?></option>
                  <option value="2"><?php echo $text_flyout_position_li; ?></option>
              <?php } else { ?>
                  <option value="1"><?php echo $text_flyout_position_ul; ?></option>
                  <option value="2" selected="selected"><?php echo $text_flyout_position_li; ?></option>
              <?php } ?>
		</select>
		</div>
		<h2 class="h2settings"><?php echo $text_languagerelated; ?></h2>

		<?php foreach ($languages as $language) { ?>
		<div class="settings-row">
	    <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
		<?php echo $text_settings_mobilemenuname; ?>
	    <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_language[mobilemenuname][<?php echo $language['language_id']; ?>]" value="<?php echo isset($flyoutmenu_mobilemenuname[$language['language_id']]) ? $flyoutmenu_mobilemenuname[$language['language_id']] : ''; ?>" />
		</div>
        <?php } ?>
		<?php foreach ($languages as $language) { ?>
		<div class="settings-row">
	    <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $more_name; ?>
	    <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_language[more_title][<?php echo $language['language_id']; ?>]" value="<?php echo isset($flyoutmenu_more_title[$language['language_id']]) ? $flyoutmenu_more_title[$language['language_id']] : ''; ?>" />
		</div>
		<div class="settings-row">
	    <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $more2_name; ?>
	    <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_language[more2_title][<?php echo $language['language_id']; ?>]" value="<?php echo isset($flyoutmenu_more2_title[$language['language_id']]) ? $flyoutmenu_more2_title[$language['language_id']] : ''; ?>" />
		</div>
        <?php } ?>
		<?php foreach ($languages as $language) { ?>
		<div class="settings-row">
	    <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
		<?php echo $text_settings_infodname; ?>
	    <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_language[infodname][<?php echo $language['language_id']; ?>]" value="<?php echo isset($flyoutmenu_infodname[$language['language_id']]) ? $flyoutmenu_infodname[$language['language_id']] : ''; ?>" />
		</div>
        <?php } ?>
		<?php foreach ($languages as $language) { ?>
		<div class="settings-row">
	    <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
		<?php echo $text_settings_brandsdname; ?>
	    <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_language[brandsdname][<?php echo $language['language_id']; ?>]" value="<?php echo isset($flyoutmenu_brandsdname[$language['language_id']]) ? $flyoutmenu_brandsdname[$language['language_id']] : ''; ?>" />
		</div>
        <?php } ?>
		<?php foreach ($languages as $language) { ?>
		<div class="settings-row">
	    <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
		<?php echo $text_settings_latestpname; ?>
	    <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_language[latestpname][<?php echo $language['language_id']; ?>]" value="<?php echo isset($flyoutmenu_latestpname[$language['language_id']]) ? $flyoutmenu_latestpname[$language['language_id']] : ''; ?>" />
		</div>
        <?php } ?>
		<?php foreach ($languages as $language) { ?>
		<div class="settings-row">
	    <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
		<?php echo $text_settings_specialpname; ?>
	    <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_language[specialpname][<?php echo $language['language_id']; ?>]" value="<?php echo isset($flyoutmenu_specialpname[$language['language_id']]) ? $flyoutmenu_specialpname[$language['language_id']] : ''; ?>" />
		</div>
        <?php } ?>
		<?php foreach ($languages as $language) { ?>
		<div class="settings-row">
	    <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
		<?php echo $text_settings_featuredpname; ?>
	    <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_language[featuredpname][<?php echo $language['language_id']; ?>]" value="<?php echo isset($flyoutmenu_featuredpname[$language['language_id']]) ? $flyoutmenu_featuredpname[$language['language_id']] : ''; ?>" />
		</div>
        <?php } ?>
		<?php foreach ($languages as $language) { ?>
		<div class="settings-row">
	    <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
		<?php echo $text_settings_bestpname; ?>
	    <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_language[bestpname][<?php echo $language['language_id']; ?>]" value="<?php echo isset($flyoutmenu_bestpname[$language['language_id']]) ? $flyoutmenu_bestpname[$language['language_id']] : ''; ?>" />
		</div>
        <?php } ?>
		<?php foreach ($languages as $language) { ?>
		<div class="settings-row">
	    <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
		<?php echo $text_settings_viewmorename; ?>
	    <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_language[viewmorename][<?php echo $language['language_id']; ?>]" value="<?php echo isset($flyoutmenu_viewmorename[$language['language_id']]) ? $flyoutmenu_viewmorename[$language['language_id']] : ''; ?>" />
		</div>
        <?php } ?>
		<?php foreach ($languages as $language) { ?>
		<div class="settings-row">
	    <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
		<?php echo $text_settings_viewallname; ?>
	    <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_language[viewallname][<?php echo $language['language_id']; ?>]" value="<?php echo isset($flyoutmenu_viewallname[$language['language_id']]) ? $flyoutmenu_viewallname[$language['language_id']] : ''; ?>" />
		</div>
        <?php } ?>
		<h2 class="h2settings"><?php echo $text_settings_fproduct; ?></h2>
		  <div class="form-group">
            <label class="col-sm-2 control-label" for="input-product">Products</label>
            <div class="col-sm-10">
              <input type="text" name="product" value="" placeholder="Type product name" id="input-product" class="form-control" />
              <div id="featured-product" class="well well-sm" style="height: 150px; overflow: auto;">
                <?php foreach ($products as $product) { ?>
                <div id="featured-product<?php echo $product['product_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $product['name']; ?>
                  <input type="hidden" name="<?php echo $preffix;  ?>flyoutmenu_fproduct[]" value="<?php echo $product['product_id']; ?>" />
                </div>
                <?php } ?>
              </div>
            </div>
          </div>
<script type="text/javascript"><!--
$('input[name=\'product\']').autocomplete({
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item['name'],
						value: item['product_id']
					}
				}));
			}
		});
	},
	select: function(item) {
		$('input[name=\'product\']').val('');

		$('#featured-product' + item['value']).remove();

		$('#featured-product').append('<div id="featured-product' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="<?php echo $preffix;  ?>flyoutmenu_fproduct[]" value="' + item['value'] + '" /></div>');
	}
});

$('#featured-product').delegate('.fa-minus-circle', 'click', function() {
	$(this).parent().remove();
});
//--></script>
		</div>
		<div class="col-sm-7 col-xs-12" >
		<div class="row">
		<div class="col-sm-6 col-xs-12" >
		<h2 class="h2settings"><?php echo $text_more_dropdown; ?></h2>
		 <div class="well well-sm" style="height: 250px; overflow: auto;">
                  <?php $class = 'odd'; ?>
                  <?php foreach ($categories as $kat) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array($kat['category_id'], $flyoutmenu_more)) { ?>
                    <input type="checkbox" name="<?php echo $preffix;  ?>flyoutmenu_more[]" value="<?php echo $kat['category_id']; ?>" checked="checked" />
                    <?php echo $kat['name']; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="<?php echo $preffix;  ?>flyoutmenu_more[]" value="<?php echo $kat['category_id']; ?>" />
                    <?php echo $kat['name']; ?>
                    <?php } ?>
                  </div>
                  <?php } ?>
        </div>
        <a onclick="$(this).parent().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a>
		</div>
		<div class="col-sm-6 col-xs-12" >
		<h2 class="h2settings"><?php echo $text_more2_dropdown; ?></h2>
		 <div class="well well-sm" style="height: 250px; overflow: auto;">
                  <?php $class = 'odd'; ?>
                  <?php foreach ($categories as $kat) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array($kat['category_id'], $flyoutmenu_more2)) { ?>
                    <input type="checkbox" name="<?php echo $preffix;  ?>flyoutmenu_more2[]" value="<?php echo $kat['category_id']; ?>" checked="checked" />
                    <?php echo $kat['name']; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="<?php echo $preffix;  ?>flyoutmenu_more2[]" value="<?php echo $kat['category_id']; ?>" />
                    <?php echo $kat['name']; ?>
                    <?php } ?>
                  </div>
                  <?php } ?>
        </div>
        <a onclick="$(this).parent().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a>
		</div>
		</div>
		<br/>
		<h2 class="h2settings"><?php echo $text_customization; ?></h2>
		<div class="settings-row">
		<b>  Apply the customization settings from below? </b>
		<?php if ($flyoutmenu_settings_status) { ?>
                <input type="radio" name="<?php echo $preffix;  ?>flyoutmenu_settings_status" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="<?php echo $preffix;  ?>flyoutmenu_settings_status" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="<?php echo $preffix;  ?>flyoutmenu_settings_status" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="<?php echo $preffix;  ?>flyoutmenu_settings_status" value="0" checked="checked" />
                <?php echo $text_no; ?>
        <?php } ?>
	    </div>
		<div class="settings-row">
		Menu font family: <span style="color: #06f; font-weight: normal; font-size: 11px;">( if you want to use another font in the menu put it in here )</span>
		<input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[fontf]" value="<?php echo isset($settings['fontf']) ? $settings['fontf'] : ''; ?>" size="25" />
		</div>
		<div class="settings-row">
		Menu main items font size:
		<select name="<?php echo $preffix;  ?>flyoutmenu_settings[topfont]">
			      <?php if (isset($settings['topfont'])) { ?>
                  <option value="<?php echo $settings['topfont']; ?>" selected="selected"><?php echo $settings['topfont']; ?></option>
                  <?php } ?>
				  <option value="13px">13px</option>
                  <option value="12px">12px</option>
                  <option value="14px">14px</option>
                  <option value="15px">15px</option>
                  <option value="16px">16px</option>
                  <option value="18px">18px</option>
		 </select>
		</div>
		<div class="settings-row">
		Menu flyout items font size:
		<select name="<?php echo $preffix;  ?>flyoutmenu_settings[dropfont]">
			      <?php if (isset($settings['dropfont'])) { ?>
                  <option value="<?php echo $settings['dropfont']; ?>" selected="selected"><?php echo $settings['dropfont']; ?></option>
                  <?php } ?>
				  <option value="12px">12px</option>
                  <option value="13px">13px</option>
                  <option value="14px">14px</option>
                  <option value="15px">15px</option>
                  <option value="16px">16px</option>
                  <option value="18px">18px</option>
		 </select>
		</div>

		<div class="settings-row">
		 Menu background gradient:
	     <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[bg]" class="colors" value="<?php echo isset($settings['bg']) ? $settings['bg'] : ''; ?>" size="7" /> to
		 <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[bg2]" class="colors" value="<?php echo isset($settings['bg2']) ? $settings['bg2'] : ''; ?>" size="7" />
	    </div>
		<div class="settings-row">
		 Menu border:
		 <select name="<?php echo $preffix;  ?>flyoutmenu_settings[tmborderpx]">
			      <?php if (isset($settings['tmborderpx'])) { ?>
                  <option value="<?php echo $settings['tmborderpx']; ?>" selected="selected"><?php echo $settings['tmborderpx']; ?></option>
                  <?php } ?>
				  <option value="default">default</option>
                  <option value="1px">1px</option>
                  <option value="2px">2px</option>
                  <option value="3px">3px</option>
                  <option value="4px">4px</option>
                  <option value="5px">5px</option>
		 </select>
		 <select name="<?php echo $preffix;  ?>flyoutmenu_settings[tmbordero]">
			      <?php if (isset($settings['tmbordero'])) { ?>
                  <option value="<?php echo $settings['tmbordero']; ?>" selected="selected"><?php echo $settings['tmbordero']; ?></option>
                  <?php } ?>
                  <option value="all-around">all-around</option>
                  <option value="top">top</option>
                  <option value="left">left</option>
                  <option value="right">right</option>
                  <option value="bottom">bottom</option>
		 </select>
         <select name="<?php echo $preffix;  ?>flyoutmenu_settings[tmborders]">
			      <?php if (isset($settings['tmborders'])) { ?>
                  <option value="<?php echo $settings['tmborders']; ?>" selected="selected"><?php echo $settings['tmborders']; ?></option>
                  <?php } ?>
                  <option value="solid">solid</option>
                  <option value="dotted">dotted</option>
                  <option value="dashed">dashed</option>
		</select>
		 <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[tmborderc]" class="colors" value="<?php echo isset($settings['tmborderc']) ? $settings['tmborderc'] : ''; ?>" size="7" />
	    </div>
		<div class="settings-row">
	     Menu title color:
	     <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[ttlc]" class="colors" value="<?php echo isset($settings['ttlc']) ? $settings['ttlc'] : ''; ?>" size="7" />
		</div>
		<div class="settings-row">
	     Menu item color:
	     <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[tlc]" class="colors" value="<?php echo isset($settings['tlc']) ? $settings['tlc'] : ''; ?>" size="7" />
		  >> on hover >>
		 <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[tlch]" class="colors" value="<?php echo isset($settings['tlch']) ? $settings['tlch'] : ''; ?>" size="7" />
		</div>
		<div class="settings-row">
	     Menu item and title border color:
	     <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[tbc]" class="colors" value="<?php echo isset($settings['tbc']) ? $settings['tbc'] : ''; ?>" size="7" />
		</div>
		<div class="settings-row">
	     Menu item text shadow color:
	     <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[tlcts]" class="colors" value="<?php echo isset($settings['tlcts']) ? $settings['tlcts'] : ''; ?>" size="7" />
		  >> on hover >>
		 <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[tlchts]" class="colors" value="<?php echo isset($settings['tlchts']) ? $settings['tlchts'] : ''; ?>" size="7" />
		</div>
		<div class="settings-row">
	     Menu item background on hover:
	     <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[tlb]" class="colors" value="<?php echo isset($settings['tlb']) ? $settings['tlb'] : ''; ?>" size="7" />
		</div>
	    <div class="settings-row">
		 Flyout background:
	     <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[dbg]" class="colors" value="<?php echo isset($settings['dbg']) ? $settings['dbg'] : ''; ?>" size="7" />
		</div>
	    <div class="settings-row">
		 Flyout + Flyout background:
	     <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[fybg]" class="colors" value="<?php echo isset($settings['fybg']) ? $settings['fybg'] : ''; ?>" size="7" />
		</div>
		<div class="settings-row">
		 Flyout  border:
		 <select name="<?php echo $preffix;  ?>flyoutmenu_settings[slborderpx]">
			      <?php if (isset($settings['slborderpx'])) { ?>
                  <option value="<?php echo $settings['slborderpx']; ?>" selected="selected"><?php echo $settings['slborderpx']; ?></option>
                  <?php } ?>
				  <option value="default">default</option>
                  <option value="1px">1px</option>
                  <option value="2px">2px</option>
                  <option value="3px">3px</option>
                  <option value="4px">4px</option>
                  <option value="5px">5px</option>
		 </select>
		 <select name="<?php echo $preffix;  ?>flyoutmenu_settings[slbordero]">
			      <?php if (isset($settings['slbordero'])) { ?>
                  <option value="<?php echo $settings['slbordero']; ?>" selected="selected"><?php echo $settings['slbordero']; ?></option>
                  <?php } ?>
                  <option value="all-around">all-around</option>
                  <option value="top">top</option>
                  <option value="left">left</option>
                  <option value="right">right</option>
                  <option value="bottom">bottom</option>
		 </select>
         <select name="<?php echo $preffix;  ?>flyoutmenu_settings[slborders]">
			      <?php if (isset($settings['slborders'])) { ?>
                  <option value="<?php echo $settings['slborders']; ?>" selected="selected"><?php echo $settings['slborders']; ?></option>
                  <?php } ?>
                  <option value="solid">solid</option>
                  <option value="dotted">dotted</option>
                  <option value="dashed">dashed</option>
		</select>
		 <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[slborderc]" class="colors" value="<?php echo isset($settings['slborderc']) ? $settings['slborderc'] : ''; ?>" size="7" />
	    </div>
	    <div class="settings-row">
		 Flyout first level item color:
	     <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[dic]" class="colors" value="<?php echo isset($settings['dic']) ? $settings['dic'] : ''; ?>" size="7" />
		  >> on hover >>
	     <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[dich]" class="colors" value="<?php echo isset($settings['dich']) ? $settings['dich'] : ''; ?>" size="7" />
		</div>
	    <div class="settings-row">
		 Flyout first level item background color:
	     <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[dib]" class="colors" value="<?php echo isset($settings['dib']) ? $settings['dib'] : ''; ?>" size="7" />
		  >> on hover >>
	     <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[dibh]" class="colors" value="<?php echo isset($settings['dibh']) ? $settings['dibh'] : ''; ?>" size="7" />
		</div>
		<div class="settings-row">
		 Flyout first level item border:
		 <select name="<?php echo $preffix;  ?>flyoutmenu_settings[diborderpx]">
			      <?php if (isset($settings['diborderpx'])) { ?>
                  <option value="<?php echo $settings['diborderpx']; ?>" selected="selected"><?php echo $settings['diborderpx']; ?></option>
                  <?php } ?>
				  <option value="default">default</option>
                  <option value="1px">1px</option>
                  <option value="2px">2px</option>
                  <option value="3px">3px</option>
                  <option value="4px">4px</option>
                  <option value="5px">5px</option>
		 </select>
		 <select name="<?php echo $preffix;  ?>flyoutmenu_settings[dibordero]">
			      <?php if (isset($settings['dibordero'])) { ?>
                  <option value="<?php echo $settings['dibordero']; ?>" selected="selected"><?php echo $settings['dibordero']; ?></option>
                  <?php } ?>
                  <option value="all-around">all-around</option>
                  <option value="top">top</option>
                  <option value="left">left</option>
                  <option value="right">right</option>
                  <option value="bottom">bottom</option>
		 </select>
         <select name="<?php echo $preffix;  ?>flyoutmenu_settings[diborders]">
			      <?php if (isset($settings['diborders'])) { ?>
                  <option value="<?php echo $settings['diborders']; ?>" selected="selected"><?php echo $settings['diborders']; ?></option>
                  <?php } ?>
                  <option value="solid">solid</option>
                  <option value="dotted">dotted</option>
                  <option value="dashed">dashed</option>
		</select>
		 <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[diborderc]" class="colors" value="<?php echo isset($settings['diborderc']) ? $settings['diborderc'] : ''; ?>" size="7" />
	    </div>
	    <div class="settings-row">
	     Flyout - second level item color:
	     <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[slc]" class="colors" value="<?php echo isset($settings['slc']) ? $settings['slc'] : ''; ?>" size="7" />
		  >> on hover >>
	     <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[slch]" class="colors" value="<?php echo isset($settings['slch']) ? $settings['slch'] : ''; ?>" size="7" />
		</div>
	    <div class="settings-row">
	     Flyout - second level item background color:
	     <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[slb]" class="colors" value="<?php echo isset($settings['slb']) ? $settings['slb'] : ''; ?>" size="7" />
		  >> on hover >>
	     <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[slbh]" class="colors" value="<?php echo isset($settings['slbh']) ? $settings['slbh'] : ''; ?>" size="7" />
		</div>
	    <div class="settings-row">
	     Flyout + Flyout - Item color:
	     <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[flyic]" class="colors" value="<?php echo isset($settings['flyic']) ? $settings['flyic'] : ''; ?>" size="7" />
		  >> on hover >>
	     <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[flyich]" class="colors" value="<?php echo isset($settings['flyich']) ? $settings['flyich'] : ''; ?>" size="7" />
		</div>
	    <div class="settings-row">
	     Flyout + Flyout - Item border:
		 <select name="<?php echo $preffix;  ?>flyoutmenu_settings[flyiborderpx]">
			      <?php if (isset($settings['flyiborderpx'])) { ?>
                  <option value="<?php echo $settings['flyiborderpx']; ?>" selected="selected"><?php echo $settings['flyiborderpx']; ?></option>
                  <?php } ?>
				  <option value="default">default</option>
                  <option value="1px">1px</option>
                  <option value="2px">2px</option>
                  <option value="3px">3px</option>
                  <option value="4px">4px</option>
                  <option value="5px">5px</option>
		 </select>
		 <select name="<?php echo $preffix;  ?>flyoutmenu_settings[flyibordero]">
			      <?php if (isset($settings['flyibordero'])) { ?>
                  <option value="<?php echo $settings['flyibordero']; ?>" selected="selected"><?php echo $settings['flyibordero']; ?></option>
                  <?php } ?>
                  <option value="all-around">all-around</option>
                  <option value="top">top</option>
                  <option value="left">left</option>
                  <option value="right">right</option>
                  <option value="bottom">bottom</option>
		 </select>
         <select name="<?php echo $preffix;  ?>flyoutmenu_settings[flyiborders]">
			      <?php if (isset($settings['flyiborders'])) { ?>
                  <option value="<?php echo $settings['flyiborders']; ?>" selected="selected"><?php echo $settings['flyiborders']; ?></option>
                  <?php } ?>
                  <option value="solid">solid</option>
                  <option value="dotted">dotted</option>
                  <option value="dashed">dashed</option>
		</select>
		 <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[flyiborderc]" class="colors" value="<?php echo isset($settings['flyiborderc']) ? $settings['flyiborderc'] : ''; ?>" size="7" />
	    </div>
		<div class="settings-row">
	      Flyout + Flyout - Item background on hover:
	     <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[flyib]" class="colors" value="<?php echo isset($settings['flyib']) ? $settings['flyib'] : ''; ?>" size="7" />
		</div>
		<div class="settings-row">
	      Flyout title color (if title is displayed):
	     <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[drtc]" class="colors" value="<?php echo isset($settings['drtc']) ? $settings['drtc'] : ''; ?>" size="7" />
		</div>
		<div class="settings-row">
	     Flyout title border:
		 <select name="<?php echo $preffix;  ?>flyoutmenu_settings[drtborderpx]">
			      <?php if (isset($settings['drtborderpx'])) { ?>
                  <option value="<?php echo $settings['drtborderpx']; ?>" selected="selected"><?php echo $settings['drtborderpx']; ?></option>
                  <?php } ?>
				  <option value="default">default</option>
                  <option value="1px">1px</option>
                  <option value="2px">2px</option>
                  <option value="3px">3px</option>
                  <option value="4px">4px</option>
                  <option value="5px">5px</option>
		 </select>
		 <select name="<?php echo $preffix;  ?>flyoutmenu_settings[drtbordero]">
			      <?php if (isset($settings['drtbordero'])) { ?>
                  <option value="<?php echo $settings['drtbordero']; ?>" selected="selected"><?php echo $settings['drtbordero']; ?></option>
                  <?php } ?>
                  <option value="all-around">all-around</option>
                  <option value="top">top</option>
                  <option value="left">left</option>
                  <option value="right">right</option>
                  <option value="bottom">bottom</option>
		 </select>
         <select name="<?php echo $preffix;  ?>flyoutmenu_settings[drtborders]">
			      <?php if (isset($settings['drtborders'])) { ?>
                  <option value="<?php echo $settings['drtborders']; ?>" selected="selected"><?php echo $settings['drtborders']; ?></option>
                  <?php } ?>
                  <option value="solid">solid</option>
                  <option value="dotted">dotted</option>
                  <option value="dashed">dashed</option>
		</select>
		 <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[drtborderc]" class="colors" value="<?php echo isset($settings['drtborderc']) ? $settings['drtborderc'] : ''; ?>" size="7" />
	    </div>
	    <div class="settings-row">
	     Flyout - price color:
	     <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[pricec]" class="colors" value="<?php echo isset($settings['pricec']) ? $settings['pricec'] : ''; ?>" size="7" />
		  >> old price >>
	     <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[pricech]" class="colors" value="<?php echo isset($settings['pricech']) ? $settings['pricech'] : ''; ?>" size="7" />
		</div>
	    <div class="settings-row">
	     Flyout - view all link color(if displayed):
	     <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[valc]" class="colors" value="<?php echo isset($settings['valc']) ? $settings['valc'] : ''; ?>" size="7" />
		  >> on hover >>
	     <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[valch]" class="colors" value="<?php echo isset($settings['valch']) ? $settings['valch'] : ''; ?>" size="7" />
		</div>
		<div class="settings-row">
		 Flyout - view all link background gradient:
	     <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[valb]" class="colors" value="<?php echo isset($settings['valb']) ? $settings['valb'] : ''; ?>" size="7" /> to
		 <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[valb2]" class="colors" value="<?php echo isset($settings['valb2']) ? $settings['valb2'] : ''; ?>" size="7" />
	    </div>
		<div class="settings-row">
	     Flyout - view all link border:
		 <select name="<?php echo $preffix;  ?>flyoutmenu_settings[valborderpx]">
			      <?php if (isset($settings['valborderpx'])) { ?>
                  <option value="<?php echo $settings['valborderpx']; ?>" selected="selected"><?php echo $settings['valborderpx']; ?></option>
                  <?php } ?>
				  <option value="default">default</option>
                  <option value="1px">1px</option>
                  <option value="2px">2px</option>
                  <option value="3px">3px</option>
                  <option value="4px">4px</option>
                  <option value="5px">5px</option>
		 </select>
		 <select name="<?php echo $preffix;  ?>flyoutmenu_settings[valbordero]">
			      <?php if (isset($settings['valbordero'])) { ?>
                  <option value="<?php echo $settings['valbordero']; ?>" selected="selected"><?php echo $settings['valbordero']; ?></option>
                  <?php } ?>
                  <option value="all-around">all-around</option>
                  <option value="top">top</option>
                  <option value="left">left</option>
                  <option value="right">right</option>
                  <option value="bottom">bottom</option>
		 </select>
         <select name="<?php echo $preffix;  ?>flyoutmenu_settings[valborders]">
			      <?php if (isset($settings['valborders'])) { ?>
                  <option value="<?php echo $settings['valborders']; ?>" selected="selected"><?php echo $settings['valborders']; ?></option>
                  <?php } ?>
                  <option value="solid">solid</option>
                  <option value="dotted">dotted</option>
                  <option value="dashed">dashed</option>
		</select>
		 <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[valborderc]" class="colors" value="<?php echo isset($settings['valborderc']) ? $settings['valborderc'] : ''; ?>" size="7" />
	    </div>
		<div class="settings-row">
		 Expand button (mobile) - background:
	     <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[expbm]" class="colors" value="<?php echo isset($settings['expbm']) ? $settings['expbm'] : ''; ?>" size="7" /> and color: <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[expbmc]" class="colors" value="<?php echo isset($settings['expbmc']) ? $settings['expbmc'] : ''; ?>" size="7" /> <br />or if expanded
		 background: <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[expbme]" class="colors" value="<?php echo isset($settings['expbme']) ? $settings['expbme'] : ''; ?>" size="7" /> and color: <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_settings[expbmec]" class="colors" value="<?php echo isset($settings['expbmec']) ? $settings['expbmec'] : ''; ?>" size="7" />
	    </div>
		</div>
		</div>
</div>
<div class="tab-pane" id="tab-html">
		<ul class="nav nav-tabs" id="language">
			<?php foreach ($languages as $language) { ?>
				<li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
			<?php } ?>
		</ul>
		<div class="tab-content">
		 <?php foreach ($languages as $language) { ?>
          <div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
			     <div class="form-group">
                    <label class="col-sm-2 control-label" for="area1<?php echo $language['language_id']; ?>">Area 1</label>
                    <div class="col-sm-10">
                      <textarea name="<?php echo $preffix;  ?>flyoutmenu_htmlarea1[<?php echo $language['language_id']; ?>]" id="area1<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($flyoutmenu_htmlarea1[$language['language_id']]) ? $flyoutmenu_htmlarea1[$language['language_id']] : 'Insert custom code 1'; ?></textarea>
                    </div>
                 </div>
			  	 <div class="form-group">
                    <label class="col-sm-2 control-label" for="area2<?php echo $language['language_id']; ?>">Area 2</label>
                    <div class="col-sm-10">
                      <textarea name="<?php echo $preffix;  ?>flyoutmenu_htmlarea2[<?php echo $language['language_id']; ?>]" id="area2<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($flyoutmenu_htmlarea2[$language['language_id']]) ? $flyoutmenu_htmlarea2[$language['language_id']] : 'Insert custom code 2'; ?></textarea>
                    </div>
                 </div>
			  	 <div class="form-group">
                    <label class="col-sm-2 control-label" for="area3<?php echo $language['language_id']; ?>">Area 3</label>
                    <div class="col-sm-10">
                      <textarea name="<?php echo $preffix;  ?>flyoutmenu_htmlarea3[<?php echo $language['language_id']; ?>]" id="area3<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($flyoutmenu_htmlarea3[$language['language_id']]) ? $flyoutmenu_htmlarea3[$language['language_id']] : 'Insert custom code 3'; ?></textarea>
                    </div>
                 </div>
			  	 <div class="form-group">
                    <label class="col-sm-2 control-label" for="area4<?php echo $language['language_id']; ?>">Area 4</label>
                    <div class="col-sm-10">
                      <textarea name="<?php echo $preffix;  ?>flyoutmenu_htmlarea4[<?php echo $language['language_id']; ?>]" id="area4<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($flyoutmenu_htmlarea4[$language['language_id']]) ? $flyoutmenu_htmlarea4[$language['language_id']] : 'Insert custom code 4'; ?></textarea>
                    </div>
                 </div>
			  	 <div class="form-group">
                    <label class="col-sm-2 control-label" for="area5<?php echo $language['language_id']; ?>">Area 5</label>
                    <div class="col-sm-10">
                      <textarea name="<?php echo $preffix;  ?>flyoutmenu_htmlarea5[<?php echo $language['language_id']; ?>]" id="area5<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($flyoutmenu_htmlarea5[$language['language_id']]) ? $flyoutmenu_htmlarea5[$language['language_id']] : 'Insert custom code 5'; ?></textarea>
                    </div>
                 </div>
			  	 <div class="form-group">
                    <label class="col-sm-2 control-label" for="area6<?php echo $language['language_id']; ?>">Area 6</label>
                    <div class="col-sm-10">
                      <textarea name="<?php echo $preffix;  ?>flyoutmenu_htmlarea6[<?php echo $language['language_id']; ?>]" id="area6<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($flyoutmenu_htmlarea6[$language['language_id']]) ? $flyoutmenu_htmlarea6[$language['language_id']] : 'Insert custom code 6'; ?></textarea>
                    </div>
                 </div>
			  	 <div class="form-group">
                    <label class="col-sm-2 control-label" for="area7<?php echo $language['language_id']; ?>">Area 7</label>
                    <div class="col-sm-10">
                      <textarea name="<?php echo $preffix;  ?>flyoutmenu_htmlarea7[<?php echo $language['language_id']; ?>]" id="area7<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($flyoutmenu_htmlarea7[$language['language_id']]) ? $flyoutmenu_htmlarea7[$language['language_id']] : 'Insert custom code 7'; ?></textarea>
                    </div>
                 </div>
			  	 <div class="form-group">
                    <label class="col-sm-2 control-label" for="area8<?php echo $language['language_id']; ?>">Area 8</label>
                    <div class="col-sm-10">
                      <textarea name="<?php echo $preffix;  ?>flyoutmenu_htmlarea8[<?php echo $language['language_id']; ?>]" id="area8<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($flyoutmenu_htmlarea8[$language['language_id']]) ? $flyoutmenu_htmlarea8[$language['language_id']] : 'Insert custom code 8'; ?></textarea>
                    </div>
                 </div>
		  </div>
		 <?php } ?>
	</div>
</div>
</div>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
var item_row = <?php echo $item_row; ?>;

function additem() {
	html  = '<tbody class="item-row" id="item-row' + item_row + '">';
	html += '  <tr>';
	html += '    <td class="text-left"><select class="item-type" style="border: 4px solid #333;" id="item-type' + item_row + '" name="<?php echo $preffix;  ?>flyoutmenu_item[' + item_row + '][type]">';
	html += '      <option class="ocat" id="ocat' + item_row + '" value="cat"><?php echo $type_cat; ?></option>';
	html += '      <option class="oinfol" id="oinfol' + item_row + '" value="infol"><?php echo $type_infol; ?></option>';
	html += '      <option class="infod" value="infod"><?php echo $type_infod; ?></option>';
	html += '      <option class="ocustom" id="ocustom' + item_row + '" value="custom"><?php echo $type_custom; ?></option>';
	html += '      <option class="mand" id="mand' + item_row + '" value="mand"><?php echo $type_mand; ?></option>';
	html += '      <option class="more" id="more' + item_row + '" value="more"><?php echo $type_more; ?></option>';
	html += '      <option class="moredoi" id="moredoi' + item_row + '" value="more2"><?php echo $type_more2; ?></option>';
	html += '      <option class="oproducts" id="oproducts' + item_row + '" value="products"><?php echo $type_products; ?></option>';
	html += '      <option class="catprods" id="catprods' + item_row + '" value="catprods"><?php echo $type_catprods; ?></option>';
	html += '      <option class="login" id="login' + item_row + '" value="login"><?php echo $type_login; ?></option>';
	html += '    </select><div class="viewsel viewsel' + item_row + '"><b><?php echo $text_sview; ?> </b><select name="<?php echo $preffix;  ?>flyoutmenu_item[' + item_row + '][view]"><option value="0" selected="selected"><?php echo $text_slist; ?></option><option value="1"><?php echo $text_sgrid; ?></option><option value="f0"><?php echo $text_dflist; ?></option><option value="f1"><?php echo $text_dfgrid; ?></option></select></div></td>';
	html += '    <td class="text-left"><div style="position: relative;"><div class="sorder"><?php echo $text_sorder; ?><input size="2" type="text" name="<?php echo $preffix;  ?>flyoutmenu_item[' + item_row + '][sorder]" value="" /></div><div id="cat-type' + item_row + '" class="typediv cat-type"><h3 class="superh3"><?php echo $entry_category; ?></h3><select style="width: 310px;" name="<?php echo $preffix;  ?>flyoutmenu_item[' + item_row + '][category_id]">';
	<?php foreach ($categories as $category ){ ?>
	html += '      <option value="<?php echo $category['category_id']; ?>"><?php echo str_replace("'", "", $category['name']); ?></option>';
	<?php } ?>
	html += '    </select></div>';
	html += '     <div id="info-type' + item_row + '" class="typediv info-type"><h3 class="superh3"><?php echo $entry_information; ?></h3><select style="width: 310px;" name="<?php echo $preffix;  ?>flyoutmenu_item[' + item_row + '][information_id]">';
	<?php foreach ($informations as $information ){ ?>
	html += '      <option value="<?php echo $information['information_id']; ?>"><?php echo str_replace("'", "", $information['name']); ?></option>';
	<?php } ?>
	html += '    </select></div>';
	html += '    <div id="oproducts-type' + item_row + '" class="typediv oproducts-type"> <h3 class="superh3"><?php echo $text_whatproducts; ?></h3><select style="width: 310px;" name="<?php echo $preffix;  ?>flyoutmenu_item[' + item_row + '][products]"><option value="latest"><?php echo $text_productlatest; ?></option><option value="special"><?php echo $text_productspecial; ?></option><option value="featured"><?php echo $text_productfeatured; ?></option><option value="bestseller"><?php echo $text_productbestseller; ?></option></select></div>';
	html += '    <div id="productlimit-type' + item_row + '" class="typediv productlimit-type"><?php echo $text_productlimit; ?> <input size="1" type="text" name="<?php echo $preffix;  ?>flyoutmenu_item[' + item_row + '][productlimit]" value="5" /></div>';
	html += '    <div id="custom-type' + item_row + '" class="typediv custom-type"> <h3 class="superh3"><?php echo $entry_custom; ?></h3>';
    <?php foreach ($languages as $language) { ?>
	html += '     <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $custom_name; ?> <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_item[' + item_row + '][customname][<?php echo $language['language_id']; ?>]" value="" /><br /><br /> <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $custom_url; ?> <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_item[' + item_row + '][customurl][<?php echo $language['language_id']; ?>]" value="" /><br /><br />';
	<?php } ?>
	html += '    </div> <h3 class="addsuperh3" id="hideadd-type' + item_row + '"><?php echo $entry_add; ?></h3><div id="add-type' + item_row + '" class="addtypediv">';
	<?php foreach ($languages as $language) { ?>
	html +=	'		<div style="padding: 3px; background: #eee; border: 1px solid #ddd; margin-bottom: 2px; text-align: left; font-weight: bold;"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> ';
	html += '     URL: <input type="text" name="<?php echo $preffix;  ?>flyoutmenu_item[' + item_row + '][addurl][<?php echo $language['language_id']; ?>]" value="" />';

	html +=	'		<div><a href="" id="thumb-image_' + item_row + '<?php echo $language['language_id']; ?>" data-toggle="image" class="img-thumbnail"><img style="max-width: 200px" src="<?php echo $no_image; ?>" alt="" title="" data-placeholder="<?php echo $no_image; ?>" /></a><input type="hidden" name="<?php echo $preffix;  ?>flyoutmenu_item[' + item_row + '][image][<?php echo $language['language_id']; ?>]" value="" id="input-image_' + item_row + '<?php echo $language['language_id']; ?>" /></div></div>';
	<?php } ?>
	html += '		</div></div></td> ';
	html += '    <td class="text-left"><style type="text/css"> .advm' + item_row + ' .advh { display: none; } </style><div class="advm' + item_row + ' advs"><a class="expand"><?php echo $text_expando; ?></a><div class="advh"><a class="closeadvm"><strong><span style="font-size:20px;"><span style="font-family:lucida sans unicode,lucida grande,sans-serif;">x</span></span></strong></a><table class="smenua"><tr><td><?php echo $text_tlcolor; ?></td><td><input type="text" class="colors" name="<?php echo $preffix;  ?>flyoutmenu_item[' + item_row + '][tlcolor]" value="" size="7" /></td><td><?php echo $text_tlstyle; ?></td><td><input type="text" name="<?php echo $preffix;  ?>flyoutmenu_item[' + item_row + '][tlstyle]" value="" size="28" /></td></tr><tr><td><?php echo $text_chtml; ?></td><td><select name="<?php echo $preffix;  ?>flyoutmenu_item[' + item_row + '][chtml]"><option value="0"><?php echo $text_no; ?></option><option value="1"><?php echo $text_alldrop; ?></option><option value="3"><?php echo $text_overdrop; ?></option><option value="2"><?php echo $text_justadd; ?></option></select><select name="<?php echo $preffix;  ?>flyoutmenu_item[' + item_row + '][cchtml]"><option value="area1">Area 1</option><option value="area2">Area 2</option><option value="area3">Area 3</option><option value="area4">Area 4</option><option value="area5">Area 5</option><option value="area6">Area 6</option><option value="area7">Area 7</option><option value="area8">Area 8</option></select></td><td><?php echo $text_subcatdisplay; ?></td><td><select name="<?php echo $preffix;  ?>flyoutmenu_item[' + item_row + '][subcatdisplay]"><option value="all"><?php echo $text_subcatdisplay_all; ?></option><option value="level1"><?php echo $text_subcatdisplay_level1; ?></option><option value="none"><?php echo $text_subcatdisplay_none; ?></option></select></td></tr><tr><td><?php echo $text_dwidth; ?></td><td><input type="text" name="<?php echo $preffix;  ?>flyoutmenu_item[' + item_row + '][dwidth]" value="" size="3" /></td><td><?php echo $text_iwidth; ?></td><td><input type="text" name="<?php echo $preffix;  ?>flyoutmenu_item[' + item_row + '][iwidth]" value="" size="3" /></td></tr><tr><td><?php echo $text_stores; ?></td><td><div class="scrollbox" style=" width: 180px; height: 60px;"><?php $sbclass = 'even'; ?><div class="<?php echo $sbclass; ?>"><input type="checkbox" name="<?php echo $preffix;  ?>flyoutmenu_item[' + item_row + '][stores][]" value="0" checked="checked" /><?php echo $text_default; ?></div><?php foreach ($stores as $store) { ?><?php $sbclass = ($sbclass == 'even' ? 'odd' : 'even'); ?><div class="<?php echo $sbclass; ?>"><input type="checkbox" name="<?php echo $preffix;  ?>flyoutmenu_item[' + item_row + '][stores][]" value="<?php echo $store['store_id']; ?>" /><?php echo $store['name']; ?></div><?php } ?></td><td><?php echo $text_fbrands; ?></td><td><input type="text" name="<?php echo $preffix;  ?>flyoutmenu_item[' + item_row + '][fbrands]" value="" size="28" /></td></tr></table></div></div>';
	html += '</td>';
	html += '    <td class="left"><button type="button" onclick="$(\'#item-row' + item_row + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
	html += '  </tr>';
	html += '</tbody>';

	$('#item tfoot').before(html);
	item_row++;
	startColMan();
	$(".item-row .item-type").change();
}
//--></script>
<script type="text/javascript"><!--
$( document ).ready(function() {
	$(".item-row .item-type").change();
});
$(document).on('change','.item-row .item-type',function(){
  var parent = $(this).parent().parent();
  if ($(this).find('.ocat').is(":selected")) {
     parent.find('.cat-type').slideDown('fast');
     parent.find('.info-type').hide();
     parent.find('.custom-type').hide();
     parent.find('.viewsel').slideDown('fast');
     parent.find('.oproducts-type').hide();
     parent.find('.productlimit-type').hide();
  } else if ($(this).find('.oinfol').is(":selected")) {
     parent.find('.cat-type').hide();
     parent.find('.info-type').slideDown('fast');
     parent.find('.custom-type').hide();
     parent.find('.viewsel').hide();
     parent.find('.oproducts-type').hide();
     parent.find('.productlimit-type').hide();
  } else if ($(this).find('.ocustom').is(":selected")) {
     parent.find('.cat-type').hide();
     parent.find('.info-type').hide();
     parent.find('.custom-type').slideDown('fast');
     parent.find('.viewsel').hide();
     parent.find('.oproducts-type').hide();
     parent.find('.productlimit-type').hide();
  } else if ($(this).find('.mand').is(":selected") || $(this).find('.more').is(":selected") || $(this).find('.moredoi').is(":selected")) {
     parent.find('.cat-type').hide();
     parent.find('.info-type').hide();
     parent.find('.custom-type').hide();
     parent.find('.viewsel').slideDown('fast');
     parent.find('.oproducts-type').hide();
     parent.find('.productlimit-type').hide();
  } else if ($(this).find('.oproducts').is(":selected")) {
     parent.find('.oproducts-type').slideDown('fast');
     parent.find('.cat-type').hide();
     parent.find('.info-type').hide();
     parent.find('.custom-type').hide();
     parent.find('.viewsel').slideDown('fast');
     parent.find('.productlimit-type').slideDown('fast');
  } else if ($(this).find('.catprods').is(":selected")) {
     parent.find('.oproducts-type').hide();
     parent.find('.cat-type').slideDown('fast');
     parent.find('.info-type').hide();
     parent.find('.custom-type').hide();
     parent.find('.viewsel').slideDown('fast');
     parent.find('.productlimit-type').slideDown('fast');
  } else {
     parent.find('.cat-type').hide();
     parent.find('.info-type').hide();
     parent.find('.custom-type').hide();
     parent.find('.viewsel').hide();
     parent.find('.oproducts-type').hide();
     parent.find('.productlimit-type').hide();
  }
});
//--></script> 
<script type="text/javascript"><!--

$(document).on('click','.addsuperh3',function(){
	var superh3stat = $(this).hasClass('active');
	$(this).next(".addtypediv").slideToggle('fast');
	if (!superh3stat) {
		$(this).addClass('active');
		superh3stat = true;
	} else {
		$(this).removeClass('active');
		superh3stat = false;
	}
});
//--></script> 
<script type="text/javascript"><!--
	$(document).on('click','.advs .expand',function(){
		$(this).parent().find('.advh').slideToggle('fast');
	});
	$(document).on('click','.advs .advh .closeadvm',function(){
		$(this).parent().slideUp('fast');
	}); 
//--></script>
<script type="text/javascript"><!--
$('#language a:first').tab('show');
//--></script>
<script type="text/javascript"><!--
<?php foreach ($languages as $language) { ?>
$('#area1<?php echo $language['language_id']; ?>').summernote({
	height: 300
});
$('#area2<?php echo $language['language_id']; ?>').summernote({
	height: 300
});
$('#area3<?php echo $language['language_id']; ?>').summernote({
	height: 300
});
$('#area4<?php echo $language['language_id']; ?>').summernote({
	height: 300
});
$('#area5<?php echo $language['language_id']; ?>').summernote({
	height: 300
});
$('#area6<?php echo $language['language_id']; ?>').summernote({
	height: 300
});
$('#area7<?php echo $language['language_id']; ?>').summernote({
	height: 300
});
$('#area8<?php echo $language['language_id']; ?>').summernote({
	height: 300
});
<?php } ?>
//--></script>
<?php echo $footer; ?>