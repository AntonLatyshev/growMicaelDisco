<?php if ($attention) { ?>
    <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $attention; ?>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
<?php } ?>

<?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
<?php } ?>

<?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
<?php } ?>

<div class="cart-product-holder">
    <div class="cart-product-list">
        <?php foreach ($products as $product) { ?>
        <div class="product-item">
        <input type="hidden" value="<?php echo $product['key']; ?>">
            <div class="image">
                <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>">
            </div>
            <div class="info-box">
                <a href="<?php echo $product['href']; ?>" class="name"><?php echo $product['name']; ?></a>
                <?php if ($product['option']) { ?>
                    <?php foreach ($product['option'] as $option) { ?>
                        <br />
                        <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                    <?php } ?>
                <?php } ?>
                <div class="code"><?php echo $column_model . ' ' . $product['model']; ?></div>
                <div class="info-row">
                    <span class="count"><span class="quantity_<?php echo $product['product_id']; ?>"><?php echo $product['quantity']; ?></span> <?php echo $column_quantity; ?></span>
                    <button class="edit" onclick="edit_cart(<?php echo $product['product_id']; ?>)"><?php echo $column_edit; ?></button>
                    <div class="price"><span class="price_<?php echo $product['product_id']; ?>"><?php echo $product['total']; ?></span></div>
                </div>
            </div>
        </div>
        <?php } ?>
    </div>
    <div class="total-holder">
        <div class="cart-totals">
        <?php foreach ($totals as $total) { ?>
            <div class="cart-total"><?php echo $total['title']; ?>: <span class="price"><?php echo $total['text']; ?></span></div>
        <?php } ?>
        </div>
        <div class="promo">
            <div id="promo_error" class="error"></div>
            <span class="promo-handler" id="handler-promo"><?php echo $column_promo_handler; ?></span>
            <div class="info">i
                <div class="info-content"><?php echo $column_promo_info; ?></div>
            </div>
            <div class="promo-code" id="section-promo">
                <input type="text" name="coupon" id="coupon" value="<?php echo $coupon; ?>" placeholder="<?php echo $column_promo_placeholder; ?>">
                <i class="icon-confirm" id="confirm_coupon"></i>
            </div>
        </div>
        <div class="promo">
            <div id="voucher_error" class="error"></div>
            <span class="promo-handler" id="handler-voucher">voucher</span>
            <div class="info">i
                <div class="info-content">voucher</div>
            </div>
            <div class="promo-code" id="section-voucher">
                <input type="text" name="voucher" id="voucher" value="<?php echo $voucher; ?>" placeholder="voucher">
                <i class="icon-confirm" id="confirm_voucher"></i>
            </div>
        </div>
        <div class="final-price">
            <?php echo $totals_total['title']; ?>: <span class="price"><?php echo $totals_total['text']; ?></span>
        </div>
        <div class="order-holder" id="confirm-holder">
            <?php echo $payment; ?>
        </div>
    </div>
</div>

<div id="cart-popup">
</div>

<script>
    function edit_cart(product_id) {
        $.ajax({
            url: '/index.php?route=checkout/cart/edit_cart',
            type: 'post',
            data: 'product_id=' + product_id,
            dataType: 'json',
            success: function (json) {
                $('#cart-popup').html(json['success']);
                $('.cart-popup-holder').show();

            }
        });
    }

    var infoIcon = document.querySelectorAll('.cart-page .info');

    infoIcon.forEach(function(el) {
        el.addEventListener('click', function(event) {
            el.classList.toggle('active');
        });
    });
</script>