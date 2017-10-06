<ul class="list-group list-unstyled">
  <?php foreach ($categories as $category) { ?>
  <li <?php if ($category['children']) { ?>class="children <?php if ( $category['category_id'] == $category_id ) { ?>active<?php } ?>"<?php } ?>>
    <?php if (1 == 1 /* $category['category_id'] == $category_id */ ) { ?>
      <a href="<?php echo $category['href']; ?>" class="list-group-item active"><?php echo $category['name']; ?></a>
      <?php if ($category['children']) { ?>
          <ul>
        <?php foreach ($category['children'] as $child) { ?>
            <li>
          <?php if ($child['category_id'] == $child_id) { ?>
            <a href="<?php echo $child['href']; ?>" class="list-group-item active"><?php echo $child['name']; ?></a>
          <?php } else { ?>
            <a href="<?php echo $child['href']; ?>" class="list-group-item"><?php echo $child['name']; ?></a>
          <?php } ?>
            </li>
        <?php } ?>
          </ul>
      <?php } ?>
  </li>
    <?php } else { ?>
      <a href="<?php echo $category['href']; ?>" class="list-group-item"><?php echo $category['name']; ?></a>
    <?php } ?>
  <?php } ?>
</ul>
