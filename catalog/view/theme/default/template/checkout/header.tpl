<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?php echo $title; ?></title>
    <link href="/catalog/view/theme/default/stylesheet/checkout/index.css" rel="stylesheet">
    <link href="/catalog/view/theme/default/stylesheet/checkout/style.css" rel="stylesheet">
    <script src="/catalog/view/javascript/checkout/vendor/modernizr.js"></script>
    <script src="/catalog/view/javascript/checkout/jquery-3.1.0.min.js"></script>
    <script src="/catalog/view/javascript/checkout/alert.js"></script>
    <script src="/catalog/view/javascript/checkout/button.js"></script>
    <script src="/catalog/view/javascript/checkout/app.js"></script>
</head>
<body>
<div class="wrapper cart-page">
    <header class="header">
        <a href="/" class="logo-cart">
            <img src="/catalog/view/theme/default/image/checkout/logo.png" alt="cart">
        </a>
        <div class="cart-contacts">
            <div class="cart-work-time">
                <?php echo $text_work_time; ?> <a href="#" class="handler-work-time"><?php echo $text_work_time1; ?></a>
                <div class="cart-work-time__popup">
                    <?php echo $popup_work_time; ?>
                </div>
            </div>
            <div class="cart-phone">
                <?php if (!empty($telephone)) { ?>
                    <a href="tel:<?php echo $telephone ?>"><?php echo $telephone ?></a>
                <?php } ?>
                <?php if (!empty($telephone_2)) { ?>
                    <a href="tel:<?php echo $telephone_2 ?>"><?php echo $telephone_2 ?></a>
                <?php } ?>
                <?php if (!empty($telephone_3)) { ?>
                    <a href="tel:<?php echo $telephone_3 ?>"><?php echo $telephone_3 ?></a>
                <?php } ?>
            </div>
        </div>
    </header>
