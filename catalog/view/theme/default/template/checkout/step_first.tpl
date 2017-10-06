<div class="step-heading">
    <span class="number">1</span>
    <span class="label"><?php echo $text_title; ?><?php if ( $step_second ) { ?> <a href="#" class="edit active" onclick="editStepFirst(); return false;"><?php echo $text_edit; ?></a><?php } ?></span>
</div>
<?php if ( !$step_second ) { ?>
<div class="step-hidden">
    <?php if ( !$logged ) { ?>
    <div class="not-login">
        <ul class="form-tab-nav">
            <li<?php if ( !$customer ) { ?> class="active"<?php } ?> data-customer="0"><a href="#new-customer"><?php echo $text_new_customer; ?></a></li>
            <li<?php if ( $customer ) { ?> class="active"<?php } ?> data-customer="1"><a href="#old-customer"><?php echo $text_old_customer; ?></a></li>
            <input type="hidden" name="customer">
        </ul>
        <div class="cart-froms-tab" id="validate-customer">
            <?php if ( !$customer ) { ?>
            <!-- new customer form-->
            <div class="tab new-customer active" id="new-customer">
                <div class="row" id="type-account">
                    <label for="with-register">
                        <input type="checkbox" name="account" value="<?php if ($account == 'register') { ?>0<?php } else { ?>1<?php } ?>"<?php if ($account == 'register') { ?> checked="checked"<?php } ?> id="with-register"><span><?php echo $text_reg_customer; ?></span>
                    </label>
                </div>
                <div class="row name">
                    <input type="text" name="firstname" value="<?php echo $firstname; ?>" placeholder="<?php echo $entry_firstname; ?>" autocomplete="off" />
                </div>
                <div class="row country">
                    <input type="text" name="country" value="<?php echo $country; ?>" placeholder="<?php echo $entry_country; ?>" autocomplete="off">
                    <input type="hidden" name="country_id" value="<?php echo $country_id; ?>">
                    <span class="city-example"><?php echo $text_example; ?>, <a href="#"><?php echo $text_example_country; ?></a></span>
                </div>
                <div class="row city">
                    <input type="text" name="zone" value="<?php echo $zone; ?>" placeholder="<?php echo $entry_city; ?>" autocomplete="off">
                    <input type="hidden" name="zone_id" value="<?php echo $zone_id; ?>">
                    <input type="hidden" name="zone_ref" value="<?php echo $zone_ref; ?>">
                    <span class="city-example"><?php echo $text_example; ?>, <a href="#"><?php echo $text_example_city; ?></a></span>
                </div>
                <div class="row">
                    <input type="text" name="telephone" value="<?php echo $telephone; ?>" placeholder="<?php echo $entry_telephone; ?>" autocomplete="off" />
                </div>
                <?php if ($account == 'register') { ?>
                    <div class="row">
                        <input type="text" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" autocomplete="off" />
                    </div>
                    <div class="row password">
                        <input type="password" name="password" value="" placeholder="<?php echo $entry_password; ?>" />
                    </div>
                    <div class="row password">
                        <input type="password" name="confirm" value="" placeholder="<?php echo $entry_confirm; ?>" />
                    </div>
                <?php } ?>
                <div class="row row-box">
                    <button id="second-step"><?php echo $text_next_step; ?></button>
                </div>
            </div>
            <?php } else { ?>
            <!-- old customer  form -->
            <div class="tab old-customer active" id="old-customer">
                <div class="row">
                    <input type="text" name="email" value="" placeholder="<?php echo $entry_email; ?>" autocomplete="off" />
                </div>
                <div class="row password">
                    <input type="password" name="password" value="" placeholder="<?php echo $entry_password; ?>" />
                </div>
                <div class="row row-box">
                    <button type="button" id="button-login" data-loading-text="<?php echo $button_loading; ?>"><?php echo $button_login; ?></button>
                    <a href="<?php echo $forgotten; ?>" class="forgot-passwd"><?php echo $text_forgotten; ?></a>
                </div>
            </div>
            <?php } ?>
        </div>
    </div>
    <?php } else { ?>
    <div class="login-success" id="validate-customer">
        <div class="row name">
            <input type="text" name="firstname" value="<?php echo $firstname; ?>" placeholder="<?php echo $entry_firstname; ?>" autocomplete="off" />
        </div>
        <div class="row country">
            <input type="text" name="country" value="<?php echo $country; ?>" placeholder="<?php echo $entry_country; ?>" autocomplete="off">
            <input type="hidden" name="country_id" value="<?php echo $country_id; ?>">
            <span class="city-example"><?php echo $text_example; ?>, <a href="#"><?php echo $text_example_country; ?></a></span>
        </div>
        <div class="row city">
            <input type="text" name="zone" value="<?php echo $zone; ?>" placeholder="<?php echo $entry_city; ?>" autocomplete="off">
            <input type="hidden" name="zone_id" value="<?php echo $zone_id; ?>">
            <input type="hidden" name="zone_ref" value="<?php echo $zone_ref; ?>">
            <span class="city-example"><?php echo $text_example; ?>, <a href="#"><?php echo $text_example_city; ?></a></span>
        </div>
        <div class="row">
            <input type="text" name="telephone" value="<?php echo $telephone; ?>" placeholder="<?php echo $entry_telephone; ?>" autocomplete="off" />
        </div>
        <div class="row row-box">
            <button id="second-step"><?php echo $button_next; ?></button>
        </div>
    </div>
    <?php } ?>
</div>
    <script>
        $('input[name=\'country\']').autocomplete({
            'source': function(request, response) {
                $.ajax({
                    url: '/index.php?route=checkout/shipping/autoCompleteCountry&filter_name=' +  encodeURIComponent(request),
                    dataType: 'json',
                    success: function(json) {
                        json.unshift({
                            country_id: 0,
                            name: '<?php echo $text_none; ?>'
                        });

                        response($.map(json, function(item) {
                            return {
                                label: item['name'],
                                value: item['country_id']
                            }
                        }));
                    }
                });
            },
            'select': function(item) {
                $('input[name=\'country\']').val(item['label']);
                $('input[name=\'country_id\']').val(item['value']);

                $.ajax({
                    url: '/index.php?route=checkout/shipping/update',
                    type: 'post',
                    data: { 'country' : item['label'], 'country_id' : item['value'] },
                    dataType: 'json',
                    success: function(json) {
                        $('input[name=\'country\']').next('.text-danger').remove();
                        if ( json['error'] ) {
                            if ( json['error']['country'] ) {
                                $('input[name="country"]').after('<div class="text-danger">' + json['error']['country'] + '</div>');
                            }
                        }
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
            }
        });

        $('input[name=\'zone\']').autocomplete({
            'source': function(request, response) {
                $.ajax({
                    url: '/index.php?route=checkout/shipping/autoCompleteZone&filter_name=' +  encodeURIComponent(request) + '&country_id=' + $('input[name=\'country_id\']').val(),
                    dataType: 'json',
                    success: function(json) {
                        json.unshift({
                            zone_id: 0,
                            name: '<?php echo $text_none; ?>'
                        });

                        response($.map(json, function(item) {
                            return {
                                label: item['name'],
                                value: item['zone_id'],
                                zone_ref: item['zone_ref']
                            }
                        }));
                    }
                });
            },
            'select': function(item) {
                $('input[name=\'zone\']').val(item['label']);
                $('input[name=\'zone_id\']').val(item['value']);
                $('input[name=\'zone_ref\']').val(item['zone_ref']);

                $.ajax({
                    url: '/index.php?route=checkout/shipping/update',
                    type: 'post',
                    data: { 'zone' : item['label'], 'zone_id' : item['value'], 'zone_ref' : item['zone_ref'] },
                    dataType: 'json',
                    success: function(json) {
                        $('input[name=\'zone\']').next('.text-danger').remove();
                        if ( json['error'] ) {
                            if ( json['error']['zone'] ) {
                                $('input[name="zone"]').after('<div class="text-danger">' + json['error']['zone'] + '</div>');
                            }
                        }
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
            }
        });
    </script>
<?php } ?>

