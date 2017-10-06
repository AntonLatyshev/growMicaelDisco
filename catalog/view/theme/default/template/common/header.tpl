<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<!--<![endif]-->
<head>
  <meta charset="UTF-8" />
  <meta name="format-detection" content="telephone=no">
  <meta name="viewport" content="width=1024">
  <title><?php echo $title; ?></title>
  <?php if ($noindex) { ?>
<!-- OCFilter Start -->
<meta name="robots" content="noindex,nofollow" />
<!-- OCFilter End -->
<?php } ?>
  <base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
  <meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
   <meta name="keywords" content= "<?php echo $keywords; ?>" />
<?php } ?>
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
<?php if ($icon) { ?>
  <link href="<?php echo $icon; ?>" rel="icon" />
<?php } ?>
<?php foreach ($links as $link) { ?>
  <link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
  <script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
  <link href="catalog/view/javascript/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen" />
  <script src="catalog/view/javascript/mf/jquery-ui.min.js" type="text/javascript"></script>

  <script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
  <link href="catalog/view/javascript/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />

  <link href="catalog/view/theme/default/stylesheet/stylesheet.css" rel="stylesheet">
  <link href="catalog/view/theme/default/stylesheet/stylesheets.css" rel="stylesheet">

  <link rel="stylesheet" href="/catalog/view/theme/default/stylesheet/index.css" media="screen" title="no title">

  <!-- jcf scripts and styles -->
  <link rel="stylesheet" href="/catalog/view/theme/default/stylesheet/jcf.css">
  <script src="/catalog/view/javascript/jcf/jcf.js"></script>
  <script src="/catalog/view/javascript/jcf/jcf.radio.js"></script>
  <script src="/catalog/view/javascript/jcf/jcf.select.js"></script>
  <script src="/catalog/view/javascript/jcf/jcf.checkbox.js"></script>
  <script src="/catalog/view/javascript/jcf/jcf.scrollable.js"></script>

  <!-- Important Owl stylesheet -->
  <link rel="stylesheet" href="catalog/view/javascript/jquery/owl-carousel/owl.transitions.css">
  <link rel="stylesheet" href="catalog/view/javascript/jquery/owl-carousel/owl.carousel.css">
  <script src="/catalog/view/javascript/jquery/owl-carousel/owl.carousel.js"></script>

  <?php foreach ($styles as $style) { ?>
    <link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
  <?php } ?>

  <script src="/catalog/view/javascript/linkInPopup.js" type="text/javascript"></script>
  <script src="/catalog/view/javascript/verge.min.js" type="text/javascript"></script>
  <script src="/catalog/view/javascript/common.js" type="text/javascript"></script>
  <script src="/catalog/view/javascript/ajax2login.js" type="text/javascript"></script>
  <script src="/catalog/view/javascript/callme.js" type="text/javascript"></script>
  <script src="/catalog/view/javascript/jquery.smoothscroll.js" type="text/javascript"></script>
  <!--<script src="catalog/view/javascript/countdown.js" type="text/javascript"></script>-->
  <script src="/catalog/view/javascript/jquery.maskedinput-1.3.min.js" type="text/javascript" charset="utf-8" ></script>
  <!--<script src="catalog/view/javascript/jquery.mixitup.js" type="text/javascript"></script>
  <script src="catalog/view/javascript/jquery.mixitup.min.js" type="text/javascript"></script>-->
  <script src="/catalog/view/javascript/jquery.validate.js" type="text/javascript"></script>
  <script src="/catalog/view/javascript/livesearch.js" type="text/javascript"></script>
  <script src="/catalog/view/javascript/jquery-ui-accordion.min.js" type="text/javascript"></script>
  <script>
    var LANGS = {};
    <?php $arr = $languagese; foreach($arr as $group => $langs){ ?>LANGS['<?php echo $group?>']={};<?php foreach($langs as $name_key => $value){?>LANGS['<?php echo $group?>']['<?php echo $name_key ;?>']='<?php echo $value ;?>';<?php } ?><?php } ?>
  </script>
<?php foreach ($scripts as $script) { ?>
  <script src="<?php echo $script; ?>" type="text/javascript"></script>
<?php } ?>
  <?php echo $google_analytics; ?>
</head>
<body class="<?php echo $class; ?>">
<div class="wrapper">
  <?php echo $content_header; ?>
  <?php if ($informations) { ?>
    <div class="container">
      <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav">
          <?php foreach ($informations as $information) { ?>
            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
          <?php } ?>
        </ul>
      </div>
    </div>
  <?php } ?>
  <nav id="top">
    <div class="container">
      <?php echo $currency; ?>
      <?php echo $language; ?>
      <div id="top-links" class="nav pull-right">
        <ul class="list-inline">
          <li id="callme-button"><i class="fa fa-phone"></i> <span><?php echo $text_callme; ?></span></li>
          <li><a href="<?php echo $contact; ?>"><i class="fa fa-phone"></i></a> <span><?php echo $telephone; ?></span></li>
          <li class="dropdown"><a href="<?php echo $account; ?>" title="<?php echo $text_account; ?>" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $text_account; ?></span> <span class="caret"></span></a>
            <ul class="dropdown-menu dropdown-menu-right">
              <?php if ($logged) { ?>
                <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
                <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
                <li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
                <li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
                <li><a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>
              <?php } else { ?>
                <li><a href="<?php echo $register; ?>"><?php echo $text_register; ?></a></li>
                <li><a id="option_login_popup_trigger" data-toggle="modal" data-target="#option_login_popup"><?php echo $text_login; ?></a></li>
              <?php } ?>
            </ul>
          </li>
          <li><a href="<?php echo $wishlist; ?>" id="wishlist-total" title="<?php echo $text_wishlist; ?>"><i class="fa fa-heart"></i> <span><?php echo $text_wishlist; ?></span></a></li>
          <li><a href="<?php echo $shopping_cart; ?>" title="<?php echo $text_shopping_cart; ?>"><i class="fa fa-shopping-cart"></i> <span><?php echo $text_shopping_cart; ?></span></a></li>
          <li><a href="<?php echo $checkout; ?>" title="<?php echo $text_checkout; ?>"><i class="fa fa-share"></i> <span><?php echo $text_checkout; ?></span></a></li>
        </ul>
      </div>
    </div>
  </nav>
  <header>
    <div class="container">
      <div class="row">
        <div class="col-sm-4">
          <div id="logo">
            <?php if ($logo) { ?>
              <a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" /></a>
            <?php } else { ?>
              <h1><a href="<?php echo $home; ?>"><?php echo $name; ?></a></h1>
            <?php } ?>
          </div>
        </div>
        <div class="col-sm-5"><?php echo $search; ?>
        </div>
        <div class="col-sm-3"><?php echo $cart; ?></div>
      </div>
    </div>
  </header>
  <?php if ($categories) { ?>
    <div class="container">
      <nav id="menu" class="navbar">
        <div class="navbar-header"><span id="category" class="visible-xs"><?php echo $text_category; ?></span>
          <button type="button" class="btn btn-navbar navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse"><i class="fa fa-bars"></i></button>
        </div>
        <div class="collapse navbar-collapse navbar-ex1-collapse">
          <ul class="nav navbar-nav">
            <?php foreach ($categories as $category) { ?>
              <?php if ($category['children']) { ?>
                <li class="dropdown <?php echo $category['active'];?>"><a href="<?php echo $category['href']; ?>" class="dropdown-toggle" data-toggle="dropdown"><?php echo $category['name']; ?></a>
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
                    <a href="<?php echo $category['href']; ?>" class="see-all"><?php echo $text_all; ?> <?php echo $category['name']; ?></a> </div>
                </li>
              <?php } else { ?>
                <li class="<?php echo $category['active'];?>"><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
              <?php } ?>
            <?php } ?>
          </ul>
        </div>
      </nav>
    </div>
  <?php } ?>
  <div class="modal fade" id="option_login_popup" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-sm">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
          <div class="modal-title" id="myModalLabel"><?php echo $text_returning_customer; ?></div>
        </div>
        <div class="modal-body">
          <div class="form-group">
            <label for="login_email" class=" control-label"><?php echo $entry_email; ?></label>
            <input type="text" name="email" class="form-control" value="" id="login_email" placeholder="<?php echo $entry_email; ?>" />
          </div>
          <div class="form-group">
            <label for="login_password" class="control-label"><?php echo $entry_password; ?></label>
            <input type="password" name="password" class="form-control" value="" id="login_password" placeholder="<?php echo $entry_password; ?>"/>
          </div>
        </div>
        <div class="modal-footer">
          <input type="button" value="<?php echo $button_login; ?>" id="button_login_popup" class="btn btn-primary pull-left" />
          <a href="<?php echo $forgotten; ?>" class="btn btn-link"><?php echo $text_forgotten; ?></a>
        </div>
      </div>
    </div>
  </div>
  <?php if ( $loggedFirst == 'on' ) { ?>
    <script>
      $(document).ready(function () {
        $('#success-logged').modal('show');
      });
    </script>
    <div class="modal fade success-order" id="success-logged" tabindex="-1" role="dialog" aria-labelledby="mySuccessLogged">
      <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <div class="modal-title" id="myModalLabel"><?php echo $text_hell; ?></div>
          </div>
          <div class="modal-body text-center"><?php echo $desc_hell; ?></div>
          <div class="modal-footer text-center"><button type="button" class="btn btn-primary btn-large" data-dismiss="modal">Ok</button></div>
        </div>
      </div>
    </div>
  <?php } ?>
<?php echo $slideshow; ?>
