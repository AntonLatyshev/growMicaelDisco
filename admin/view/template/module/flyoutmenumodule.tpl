<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
<link rel="stylesheet" type="text/css" href="view/cpicker/flyoutmenu.css" />
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-fmm" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
		  <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $heading_title; ?> &nbsp;&nbsp;&nbsp;&nbsp; <a style="color: #D83030" href="<?php echo $url_tomenu; ?>"><?php echo $text_tomenu; ?></a></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-fmm" class="form-horizontal">
		<?php foreach ($flyoutmenu_menus as $menu) { ?>
		  <input type="hidden" name="flyoutmenumodule_added_menus[]" value="<?php echo $menu['id']; ?>" />
		<?php } ?>
		<div class="form-group">
            <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
            <div class="col-sm-10">
              <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
              <?php if ($error_name) { ?>
              <div class="text-danger"><?php echo $error_name; ?></div>
              <?php } ?>
            </div>
        </div>
		<div class="form-group">
            <label class="col-sm-2 control-label" for="input-menu"><?php echo $entry_menu; ?></label>
            <div class="col-sm-10">
              <select name="menu" id="input-menu" class="form-control">
					<?php if (!$smenu) { ?>
							<option value="0" selected="selected"><?php echo $text_default_menu; ?></option>
					<?php } else { ?>
							<option value="0"><?php echo $text_default_menu; ?></option>
					<?php } ?>
					<?php foreach ($flyoutmenu_menus as $menu) { ?>
						<?php if ($menu['id'] == $smenu) { ?>
							<option value="<?php echo $menu['id']; ?>" selected="selected"><?php echo $menu['name']; ?></option>
						<?php } else { ?>
							<option value="<?php echo $menu['id']; ?>"><?php echo $menu['name']; ?></option>
						<?php } ?>
					<?php } ?>
				</select>
            </div>
        </div>
		<div class="form-group">
            <label class="col-sm-2 control-label" for="input-theme"><?php echo $entry_theme; ?></label>
            <div class="col-sm-10">
              <select name="theme" id="input-theme" class="form-control">
				  <?php if ($theme == 'default') { ?>
                  <option value="default" selected="selected">Default</option>
                  <?php } else { ?>
                  <option value="default">Default</option>
                  <?php } ?>
				  <?php if ($theme == 'fly_theme_1') { ?>
                  <option value="fly_theme_1" selected="selected">Theme 1</option>
                  <?php } else { ?>
                  <option value="fly_theme_1">Theme 1</option>
                  <?php } ?>
				  <?php if ($theme == 'fly_theme_2') { ?>
                  <option value="fly_theme_2" selected="selected">Theme 2</option>
                  <?php } else { ?>
                  <option value="fly_theme_2">Theme 2</option>
                  <?php } ?>
				  <?php if ($theme == 'fly_theme_3') { ?>
                  <option value="fly_theme_3" selected="selected">Theme 3</option>
                  <?php } else { ?>
                  <option value="fly_theme_3">Theme 3</option>
                  <?php } ?>
				  <?php if ($theme == 'fly_theme_4') { ?>
                  <option value="fly_theme_4" selected="selected">Theme 4</option>
                  <?php } else { ?>
                  <option value="fly_theme_4">Theme 4</option>
                  <?php } ?>
				  <?php if ($theme == 'fly_theme_5') { ?>
                  <option value="fly_theme_5" selected="selected">Theme 5</option>
                  <?php } else { ?>
                  <option value="fly_theme_5">Theme 5</option>
                  <?php } ?>
				</select>
            </div>
        </div>
		<div class="form-group">
            <label class="col-sm-2 control-label" for="input-pos"><?php echo $entry_pos; ?></label>
            <div class="col-sm-10">
              <select name="position" id="input-pos" class="form-control">
				  <?php if ($position == 'left') { ?>
                  <option value="left" selected="selected"><?php echo $text_left; ?></option>
                  <?php } else { ?>
                  <option value="left"><?php echo $text_left; ?></option>
                  <?php } ?>
				  <?php if ($position == 'right') { ?>
                  <option value="right" selected="selected"><?php echo $text_right; ?></option>
                  <?php } else { ?>
                  <option value="right"><?php echo $text_right; ?></option>
                  <?php } ?>
				</select>
            </div>
        </div>
	     <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="status" id="input-status" class="form-control">
                <?php if ($status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
      </form>
    </div>
  </div>
</div>
</div>
<?php echo $footer; ?>