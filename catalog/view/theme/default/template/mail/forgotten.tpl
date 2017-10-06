
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="initial-scale=1.0"/>
    <meta name="format-detection" content="telephone=no"/>
    <title><?php echo $title; ?></title>
    <style type="text/css">
        @import url('https://fonts.googleapis.com/css?family=Open+Sans:400,300,600&subset=latin,cyrillic');
        html,body {
            background-color: #fff;
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
            text-decoration: underline
        }
        a:hover {
            text-decoration: none
        }
        .button a {
            font-size:14px;
            font-family: 'Open Sans', sans-serif;
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
                text-align:center;
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
            .text-size-20 {
                font-size: 20px !important;
            }
            .text-size-14 {
                font-size: 14px !important;
            }
            body {
                width:auto!important
            }
            table[class="col1"] {
                width:100%
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
                width:280px;
                margin:0 !important
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
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
    <!-- START HEADER/BANNER -->
    <tr>
        <td align="center">
            <table class="col-600" width="600" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td align="center" valign="top" background="<?php echo $mail_background; ?>" bgcolor="<?php echo $color_background; ?>" style="color:<?php echo $color_text; ?>; background-size:cover; background-position:top;" height="400">
                    <table class="col-600" width="600" height="400" border="0" align="center" cellpadding="0" cellspacing="0">

                        <tr>
                            <td height="35"></td>
                        </tr>

                        <tr>
                            <td align="center" style="line-height: 0px;">
                                <img style="display:block; line-height:0px; font-size:0px; border:0px;" src="<?php echo $mail_logo; ?>" alt="<?php echo $config_name; ?>" />
                            </td>
                        </tr>

                        <tr>
                            <td align="center" class="text-size-20" style="font-family: 'Open Sans', sans-serif; font-size:30px; color:inherit; font-weight: 400; letter-spacing: 1px; padding: 0 10px;">
                                <?php echo $text_hello; ?>
                            </td>
                        </tr>

                        <tr>
                            <td align="center" class="text-size-14" style="font-family: 'Open Sans', sans-serif; font-size:18px; color:inherit; line-height:1.4; font-weight: 400; padding: 0 10px;">
                                <?php echo $text_description_1 . ' ' . $config_name . ' ' . $text_description_2 . '' . $date; ?>.
                            </td>
                        </tr>
                        
                        <tr>
                            <td height="40"></td>
                        </tr>
                    </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <!-- END HEADER/BANNER -->

    <!-- START SHOWCASE -->
    <tr>
        <td align="center">
            <table class="col-600" width="600" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-left:20px; margin-right:20px; border-left: 1px solid #dbd9d9; border-right: 1px solid #dbd9d9;">
                <tr>
                    <td height="50"></td>
                </tr>

                <tr>
                    <td align="left" class="text-size-14" style="font-family: 'Open Sans', sans-serif; font-size:22px; font-weight: bold; color:#2a3a4b; padding: 0 15px">
                        <span style="color:#757575;"><?php echo $text_password; ?></span> <?php echo $password; ?>
                    </td>
                </tr>

            </table>
        </td>
    </tr>
    <!-- END SHOWCASE -->

    <!-- START FOOTER -->
    <tr>
        <td align="center">
            <table class="col-600" width="600" border="0" align="center" cellpadding="0" cellspacing="0" style="color:<?php echo $color_text; ?>; border-left: 1px solid #dbd9d9; border-right: 1px solid #dbd9d9;">
                <tr>
                    <td height="55"></td>
                </tr>
                <tr>
                    <td align="center" bgcolor="<?php echo $color_background; ?>" background="<?php echo $mail_background_footer; ?>" style="background-size: cover;background-position: top;">
                        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                                <td height="40"></td>
                            </tr>

                            <tr>
                                <td align="center" class="text-size-14" style="font-family: 'Open Sans', sans-serif; font-size:20px; color:inherit; line-height:1.4;">
                                    <?php echo $text_footer; ?>
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
    <!-- END FOOTER -->
</body>
</html>
