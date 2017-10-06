<div class="module account">
  <ul>
<?php if (!$logged) { ?>
    <li class="<?php echo $active[0]; ?>"><a href="<?php echo $login; ?>"><?php echo $text_login; ?></a></li>
    <li class="<?php echo $active[1]; ?>"><a href="<?php echo $register; ?>"><?php echo $text_register; ?></a></li>
    <li class="<?php echo $active[2]; ?>"><a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a></li>
<?php } ?>
    <li class="<?php echo $active[3]; ?>"><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
<?php if ($logged) { ?>
    <li class="<?php echo $active[4]; ?>"><a href="<?php echo $edit; ?>"><?php echo $text_edit; ?></a></li>
    <li class="<?php echo $active[5]; ?>"><a href="<?php echo $password; ?>"><?php echo $text_password; ?></a></li>
<?php } ?>
    <li class="<?php echo $active[6]; ?>"><a href="<?php echo $address; ?>"><?php echo $text_address; ?></a></li>
    <li class="<?php echo $active[7]; ?>"><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
    <li class="<?php echo $active[8]; ?>"><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
    <li class="<?php echo $active[9]; ?>"><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
    <li class="<?php echo $active[10]; ?>"><a href="<?php echo $recurring; ?>"><?php echo $text_recurring; ?></a></li>
    <li class="<?php echo $active[11]; ?>"><a href="<?php echo $reward; ?>"><?php echo $text_reward; ?></a></li>
    <li class="<?php echo $active[12]; ?>"><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
    <li class="<?php echo $active[13]; ?>"><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
    <li class="<?php echo $active[14]; ?>"><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
<?php if ($logged) { ?>
    <li class="<?php echo $active[15]; ?>"><a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>
<?php } ?>
  </ul>
</div>
