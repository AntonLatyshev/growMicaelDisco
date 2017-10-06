<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="viewport" content="initial-scale=1.0"/>
  <meta name="format-detection" content="telephone=no"/>
  <title><?php echo $title; ?></title>
  <style type="text/css">
    @import "https://fonts.googleapis.com/css?family=Open+Sans:400,300,600&subset=latin,cyrillic";

    html,body {
      font-family: 'Open Sans', sans-serif;
      background-color:#fff;
      margin:0;
      padding:0
    }

    html {
      width:100%
    }

    body {
      margin:0;
      padding:0;
      -webkit-text-size-adjust:none;
      -ms-text-size-adjust:none
    }


    table {
      border-spacing:0;
      border-collapse:collapse
    }

    table td {
      border-collapse:collapse
    }

    table tr {
      border-collapse:collapse
    }

    img {
      display:block!important
    }

    br,strong br,b br,em br,i br {
      line-height:100%
    }

    a {
      color: inherit;
      text-decoration: underline;
    }
    a:hover {
      text-decoration: none;
    }

    .button a {
      font-size:14px;
      font-family:'Lato',sans-serif;
      color:#fff;
      font-weight:300;
      background:transparent
    }

    @media only screen and (max-width: 640px) {
      body {
        width:auto!important
      }

      table[class="col1"] {
        width:29%;
      }

      table[class="col2"] {
        width:47%;
        text-align:left
      }

      table[class="col3_one"] {
        width:64%;
        text-align:left;
      }

      table[class="col3"] {
        width:100%;
        text-align:center
      }

      table[class="col-600"] {
        width:450px
      }

      table[class="insider"] {
        width:90%
      }

      img[class="images_style"] {
        width:60%;
        height:auto
      }

      .margin{
        margin-left: 25px;
        margin-right: 25px;
      }
    }

    @media only screen and (max-width: 480px) {
      body {
        width:auto!important
      }

      table[class="col1"] {
        width:100%;
      }

      table[class="col2"] {
        width:100%;
        text-align:left
      }

      table[class="col3"] {
        width:100%;
        text-align:center
      }

      table[class="col3_one"] {
        width:80%;
        text-align:center;
        margin: 0 20px 0 0
      }

      table[class="col-600"] {
        width:290px
      }

      table[class="insider"] {
        width:82%!important
      }

      img[class="images-style"] {
        width:60%
      }

      .button { width: 40%; display: block; }
      a.read-more { text-align: center; display: block;}
    }

    /* OUTLOOK CLASS*/
    .ExternalClass {
      background-color:#fff;
      width:100%
    }

    .ExternalClass,.ExternalClass font,.ExternalClass td,.ExternalClass p,.ExternalClass span,.ExternalClass div {
      line-height:100%
    }

    .ReadMsgBody {
      width:100%;
      background-color:#fff
    }

    /* YAHOO MAIL CLASS */
    .yshortcuts,.yshortcuts a,.yshortcuts a:link,.yshortcuts a:visited,.yshortcuts a:hover,.yshortcuts a span {
      border-bottom:none!important
    }

    /* MAILCHIMP CLASS */
    .default-edit-image {
      height:20px
    }
  </style>
  <meta name="robots" content="noindex,follow" />
</head>
<body>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="font-family: 'Open Sans', sans-serif;">
  <tr>
    <td align="center">
      <table class="col-600" width="740" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td align="center"  valign="top" background="<?php echo $mail_background; ?>" bgcolor="<?php echo $color_background; ?>" style="color:<?php echo $color_text; ?>; background-size:cover; background-position:top;" height="360">
            <table class="col-600" width="740" height="360" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="30"></td>
              </tr>
              <tr>
                <td align="center" style="line-height: 0; padding: 0 15px;">
                  <a href="<?php echo $store_url; ?>"><img style="display:block; line-height:0; font-size:0; border:0;" src="<?php echo $mail_logo; ?>" alt="<?php echo $store_name; ?>" /></a>
                </td>
              </tr>
              <tr>
                <td height="30"></td>
              </tr>
              <tr>
                <td align="left" style="padding: 0 30px; font-family: inherit; font-size:30px; color:inherit; line-height:24px; font-weight: 300; letter-spacing: 1px;">
                  <?php echo $text_order_id; ?> <span style="font-family: inherit; font-size:30px; color:inherit; line-height:39px; font-weight: 400; letter-spacing: 1px;">№<?php echo $order_id; ?></span>
                </td>
              </tr>
              <tr>
                <td align="left" style="padding: 0 30px; font-family: inherit; font-size:22px; color:inherit; line-height:24px; font-weight: 300; letter-spacing: 1px;">
                  <?php echo $text_order_status; ?> <span style="font-family: inherit; font-size:22px; color:inherit; line-height:39px; font-weight: 400; letter-spacing: 1px;"><?php echo $order_status; ?></span>
                </td>
              </tr>
              <tr>
                <td height="25"></td>
              </tr>
              <tr>
                <td align="left" style="padding: 0 30px; font-family: inherit; font-size:16px; color:inherit; line-height:1.8; font-weight: 400;">
                  <p><?php echo $text_greeting; ?></p>
                  <?php if ($customer_id) { ?>
                    <p style="margin-top: 0; margin-bottom: 15px;"><?php echo $text_link; ?></p>
                    <p style="margin: 0;"><a href="<?php echo $link; ?>"><?php echo $link; ?></a></p>
                  <?php } ?>
                  <?php if ($download) { ?>
                    <p style="margin-top: 0; margin-bottom: 15px;"><?php echo $text_download; ?></p>
                    <p style="margin: 0;"><a href="<?php echo $download; ?>"><?php echo $download; ?></a></p>
                  <?php } ?>
                </td>
              </tr>
              <tr>
                <td height="35"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td align="center">
      <table class="col-600" width="740" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-left:20px; margin-right:20px; border-left: 1px solid #dbd9d9; border-right: 1px solid #dbd9d9;">
        <tr>
          <td height="25"></td>
          <?php if ($shipping_address) { ?><td height="25"></td><?php } ?>
        </tr>
        <tr>
          <td align="left" style="width: 50%; padding: 0 30px;font-family: inherit; font-size:22px; font-weight: bold; color:#2a3a4b;"><?php echo $text_order_detail; ?></td>
          <?php if ($shipping_address) { ?>
            <td align="left" style="width: 50%; padding: 0 30px;font-family: inherit; font-size:22px; font-weight: bold; color:#2a3a4b;"><?php echo $text_shipping_address; ?></td>
          <?php } ?>
        </tr>
        <tr>
          <td height="15"></td>
          <?php if ($shipping_address) { ?><td height="15"></td><?php } ?>
        </tr>
        <tr>
          <td align="left" style="padding: 0 30px;font-family: inherit; font-size:14px; color:#757575; line-height:24px; font-weight: 400; vertical-align: top;">
            <ul style="list-style: none; padding: 0; margin: 0;">
              <li><strong><?php echo $text_date_added; ?></strong> <?php echo $date_added; ?></li>
              <li><strong><?php echo $text_email; ?></strong> <a href="mailto:<?php echo $email; ?>" style="color: inherit;"><?php echo $email; ?></a></li>
              <li><strong><?php echo $text_telephone; ?></strong> <?php echo $telephone; ?></li>
            </ul>
          </td>
          <?php if ($shipping_address) { ?>
          <td align="left" style="padding: 0 30px;font-family: inherit; font-size:14px; color:#757575; line-height:24px; font-weight: 400; vertical-align: top;">
            <p style="margin: 0;"><?php echo $shipping_address; ?></p>
          </td>
          <?php } ?>
        </tr>
        <tr>
          <td height="25"></td>
          <?php if ($shipping_address) { ?><td height="25"></td><?php } ?>
        </tr>
        <?php if ($comment) { ?>
        <tr>
          <td style="border-top: 1px solid #dbd9d9"></td>
          <?php if ($shipping_address) { ?><td style="border-top: 1px solid #dbd9d9"></td><?php } ?>
        </tr>
        <tr>
          <td height="25"></td>
          <?php if ($shipping_address) { ?><td height="25"></td><?php } ?>
        </tr>
        <?php } ?>
      </table>
    </td>
  </tr>
  <?php if ($comment) { ?>
  <tr>
    <td align="center">
      <table class="col-600" width="740" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-left:20px; margin-right:20px; border-left: 1px solid #dbd9d9; border-right: 1px solid #dbd9d9;">
        <tr>
          <td align="left" style="width: 50%; padding: 0 30px;font-family: inherit; font-size:22px; font-weight: bold; color:#2a3a4b;"><?php echo $text_instruction; ?></td>
        </tr>
        <tr>
          <td height="15"></td>
        </tr>
        <tr>
          <td align="left" style="padding: 0 30px;font-family: inherit; font-size:14px; color:#757575; line-height:24px; font-weight: 400; vertical-align: top;">
            <p style="margin: 0;"><?php echo $comment; ?></p>
          </td>
        </tr>
        <tr>
          <td height="25"></td>
        </tr>
      </table>
    </td>
  </tr>
  <?php } ?>
  <tr>
    <td align="center">
      <table align="center" class="col-600" width="740"  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="center" bgcolor="<?php echo $color_background; ?>" style="color: <?php echo $color_text; ?>;">
            <table class="col-600" width="740" align="center" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="20"></td>
              </tr>
              <tr>
                <td align="left" style="width: 50%; padding: 0 30px;font-family: inherit; font-size:22px; font-weight: bold; color:inherit;"><?php echo $text_product; ?></td>
              </tr>
              <tr>
                <td height="25"></td>
              </tr>
              <?php foreach ($products as $product) { ?>
              <tr>
                <td>
                  <table class="col1" width="184" border="0" align="left" cellpadding="0" cellspacing="0">
                    <tr>
                      <td align="center" style="padding: 0 30px">
                        <img style="display:block; line-height:0; font-size:0; border:0; background: <?php echo $product['image']; ?>;" class="images_style" src="<?php echo $product['image']; ?>" alt="<?php echo $product['name']; ?>" width="140" height="140" />
                      </td>
                    </tr>
                  </table>
                  <table class="col3_one" width="536" border="0" align="right" cellpadding="0" cellspacing="0">
                    <tr align="left" valign="top">
                      <td style="font-family: inherit; font-size:18px; color:#f1c40f; line-height:1.6; font-weight: bold;">
                        <p style="margin: 0;"><?php echo $product['name']; ?></p>
                        <?php foreach ($product['option'] as $option) { ?>
                          <br />
                          <small style="color: inherit;"> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                        <?php } ?>
                      </td>
                    </tr>
                    <tr>
                      <td height="10"></td>
                    </tr>
                    <tr align="left" valign="top">
                      <td style="font-family: inherit; font-size:14px; color:#fff; line-height:1.8; font-weight: 400;">
                        <dl style="margin: 0;">
                          <dt style="width: 100px; float: left; text-align: right; padding-right: 15px; color: #f1c40f; font-weight: 600;"><?php echo $text_model; ?>:</dt><dd style="overflow: hidden; color: inherit;"><?php echo $product['model']; ?></dd>
                          <dt style="width: 100px; float: left; text-align: right; padding-right: 15px; color: #f1c40f; font-weight: 600;"><?php echo $text_quantity; ?>:</dt><dd style="overflow: hidden; color: inherit;"><?php echo $product['quantity']; ?></dd>
                          <dt style="width: 100px; float: left; text-align: right; padding-right: 15px; color: #f1c40f; font-weight: 600;"><?php echo $text_price; ?>:</dt><dd style="overflow: hidden; color: inherit;"><?php echo $product['price']; ?></dd>
                          <dt style="width: 100px; float: left; text-align: right; padding-right: 15px; color: #f1c40f; font-weight: 600;"><?php echo $text_total; ?></dt><dd style="overflow: hidden; color: inherit;"><?php echo $product['total']; ?></dd>
                        </dl>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td height="40"></td>
              </tr>
              <?php } ?>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td align="center">
      <table class="col-600" width="740" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-left:20px; margin-right:20px; border-left: 1px solid #dbd9d9; border-right: 1px solid #dbd9d9;">
        <tr>
          <td height="30"></td>
        </tr>
        <tr>
          <td align="left" style="width: 50%; padding: 0 30px;font-family: inherit; font-size:22px; font-weight: bold; color: <?php echo $color_background; ?>;">
            <dl style="margin: 0;">
              <dt style="width: 75%; float: left; text-align: right; color: #2a3a4b; font-weight: 600; padding: 0 15px;"><?php echo $text_total; ?></dt><dd style="overflow: hidden; padding-bottom: 10px;">&nbsp;</dd>
            </dl>
          </td>
        </tr>
        <tr>
          <td align="left" style="padding: 0 30px;font-family: inherit; font-size:16px; color:#757575; line-height:1.4; font-weight: 400; vertical-align: top;">
            <dl style="margin: 0;">
              <?php foreach ($totals as $total) { ?>
                <dt style="border-bottom: 1px solid #eee; width: 75%; float: left; text-align: right; padding: 12px 15px; color: <?php echo $color_background; ?>; font-weight: 600;"><?php echo $total['title']; ?>:</dt><dd style="border-bottom: 1px solid #eee; overflow: hidden; padding: 12px 15px 12px 0;"><?php echo $total['text']; ?></dd>
              <?php } ?>
            </dl>
          </td>
        </tr>
        <tr>
          <td height="35"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td align="center">
      <table class="col-600" width="740" border="0" align="center" cellpadding="0" cellspacing="0" style="color: <?php echo $color_text; ?>;">
        <tr>
          <td align="center" bgcolor="<?php echo $color_background; ?>" background="<?php echo $mail_background_footer; ?>" style="background-size: cover; background-position: top;">
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="40"></td>
              </tr>
              <tr>
                <td align="center" class="text-size-14" style="font-family: 'Open Sans', sans-serif; font-size:20px; color: inherit; line-height:1.4;">
                  <p style="margin: 0;"><?php echo $text_footer; ?></p>
                </td>
              </tr>
              <tr>
                <td height="45"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>