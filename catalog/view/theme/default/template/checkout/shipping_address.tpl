<?php foreach ($shipping_address_fields as $key => $value) { ?>
  <?php if ($key == 'city') { ?>
    <div class="row">
      <input type="hidden" id="shipping_address_city_ref" name="city_ref" value="<?php echo $city_ref; ?>" />
      <?php if ($value == 'text') { ?>
      <input type="text" name="city" value="<?php echo $city; ?>" placeholder="<?php echo $entry_city; ?>" />
      <?php } elseif ($value == 'select') { ?>
        <select id="shipping_address_city" name="city">
          <option value=""><?php echo $text_select; ?></option>
          <?php foreach ($cities as $city) { ?>
            <option value="<?php echo $city['name']; ?>" data-ref="<?php echo $city['ref']; ?>"<?php if ($city['ref'] == $city_ref) { ?> selected="selected"<?php } ?>><?php echo $city['name']; ?></option>
          <?php } ?>
        </select>
        <script>
          document.getElementById("shipping_address_city").onchange = function () {
            var ref = this.options[this.selectedIndex].getAttribute("data-ref");
            document.getElementById("shipping_address_city_ref").value = ref;
            updateShipping();
          };
          $(function () {
            $('select[name=\'city\']').trigger('change');
          })
        </script>
      <?php } else { ?>
      <input type="text" name="city" value="<?php echo $city; ?>" placeholder="<?php echo $entry_city; ?>" />
      <?php } ?>
    </div>
  <?php } ?>
  <?php if ($key == 'address_1') { ?>
    <div class="row">
      <?php if ($value == 'text') {?>
        <input type="text" name="address_1" value="<?php echo $address_1; ?>" placeholder="<?php echo $entry_address_1; ?>" />
      <?php } elseif ($value == 'select') { ?>
        <select name="address_1">
          <option value=""><?php echo $text_select; ?></option>
        </select>
      <?php } else { ?>
        <input type="text" name="address_1" value="<?php echo $address_1; ?>" placeholder="<?php echo $entry_address_1; ?>" />
      <?php } ?>
    </div>
  <?php } ?>
  <?php if ($key == 'address_2') { ?>
    <div class="row address">
      <div class="input-row">
        <input type="text" name="address_2[street]" value="<?php echo $street; ?>" placeholder="<?php echo $entry_address_2; ?>" />
      </div>
      <div class="input-row double">
        <input type="text" name="address_2[house]" value="<?php echo $house; ?>" placeholder="<?php echo $entry_house; ?>">
        <input type="text" name="address_2[apartment]" value="<?php echo $apartment; ?>" placeholder="<?php echo $entry_apartment; ?>">
      </div>
    </div>
  <?php } ?>
<?php } ?>