<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <h1><?php echo $heading_title; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>

    <div class="container-fluid">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $heading_title; ?></h3>
            </div>
            <div class="panel-body">
                <form action="<?php echo $action; ?>" method="post" id="department_form" class="form-vertical">
                    <table  id="module" class="table table-striped table-bordered table-hover">
                        <thead>
                        <tr>
                            <td class="left"><?php echo $text_zone; ?></td>
                            <td class="left">
                                <select name="zone_id" id="input-zone" class="form-control">
                                    <option value=""><?php echo $text_none; ?></option>
                                    <?php foreach ($zones as $zone) { ?>
                                        <?php if ($zone['zone_id'] == $current_zone) { ?>
                                            <option value="<?php echo $zone['Ref']; ?>"
                                                    selected="selected"><?php echo $zone['name']; ?></option>
                                        <?php } else { ?>
                                            <option value="<?php echo $zone['Ref']; ?>"><?php echo $zone['name']; ?></option>
                                        <?php } ?>
                                    <?php } ?>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $text_city; ?></td>
                            <td>
                                <input type="hidden" name="city" value="" />
                                <select name="city_id" id="input-city" class="form-control"></select>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $text_address; ?></td>
                            <td>
                                <input type="text" name="address" value="" placeholder="<?php echo $text_address; ?>" id="input-title" class="form-control"/>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $text_phone; ?></td>
                            <td>
                                <input type="text" name="phone" value="" placeholder="<?php echo $text_phone; ?>" id="input-phone" class="form-control"/>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td class="text-right">
                                <button type="submit" class="btn btn-success"><?php echo $button_add; ?></button>
                            </td>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </form>
                <hr>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead>
                        <tr>
                            <td><?php echo $text_city; ?></td>
                            <td><?php echo $text_address; ?></td>
                            <td><?php echo $text_phone; ?></td>
                            <td><?php echo $button_delete; ?></td>
                        </tr>
                        </thead>
                        <tbody>
                        <?php if ($warenhouses) { ?>
                        <?php foreach ($warenhouses as $item) { ?>
                            <tr>
                                <td><?php echo $item['CityDescriptionRu']; ?></td>
                                <td><?php echo $item['DescriptionRu']; ?></td>
                                <td><?php echo $item['Phone']; ?></td>
                                <td>
                                    <button type="button" data-toggle="tooltip" title="" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? deleter(<?php echo $item['id']; ?>) : false;" data-original-title="Удалить"><i class="fa fa-trash-o"></i></button>
                                </td>
                            </tr>
                        <?php } ?>
                        <?php } else { ?>
                            <tr>
                                <td colspan="4" class="text-center"><?php echo $text_no_results; ?></td>
                            </tr>
                        <?php } ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.15.1/jquery.validate.min.js"></script>
<script>
    function deleter(war_id) {
        var data_delet = {war_id : war_id};
        $.ajax({
            url: 'index.php?route=sale/department/delete_wh&token=' + '<?php echo $token; ?>',
            type: 'POST',
            data: data_delet,
            success: function () {
                location.reload();
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }
    $(document).ready(function () {
        $('select[name=\'zone_id\']').on('change', function () {
            var data = {zone_ref: this.value};
            $.ajax({
                url: 'index.php?route=sale/department/getCityByZone&token=' + '<?php echo $token; ?>',
                type: 'POST',
                dataType: 'json',
                data: data,
                success: function (response) {
                    html = '<option value="">-- Ничего не выбрано --</option>';
                    if (response['cities'] && response['cities'] != '') {

                        for (i = 0; i < response['cities'].length; i++) {
                            html += '<option value="' + response['cities'][i]['Ref'] + '"';

                            html += '>' + response['cities'][i]['name'] + '</option>';
                        }
                    } else {
                        html += '<option value="0" selected="selected">Ничего нет</option>';
                    }

                    $('select[name=\'city_id\']').html(html);
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            });
        });

        $('select[name=\'zone_id\']').trigger('change');

        $('select[name=\'city_id\']').on('change', function () {
            var _this = $(this);
            $('input[name=\'city\']').val(_this.find("option:selected").text());
        });
    });

    $(document).ready(function () {
        $("#department_form").validate({
            rules: {
                zone_id: {
                    required: true
                },
                city_id: {
                    required: true
                },
                address: {
                    required: true
                },
                phone: {
                    required: true
                }
            },
            messages: {
                zone_id: {
                    required: 'Обязательно'
                },
                city_id: {
                    required: 'Обязательно'
                },
                address: {
                    required: 'Обязательно'
                },
                phone: {
                    required: 'Обязательно'
                }
            }
        });
    });
</script>

<?php echo $footer; ?>
