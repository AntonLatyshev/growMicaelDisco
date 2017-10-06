<?php echo $header; ?>
<?php echo $column_left; ?>
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
            <?php if ($error_warning) { ?>
                <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                </div>
            <?php } ?>
            <?php if ($success) { ?>
                <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                </div>
            <?php } ?>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_title; ?></h3>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-6 com-sm-12">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <div class="h4"><?php echo $text_list; ?></div>
                                </div>
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th><?php echo $column_type; ?></th>
                                                <th><?php echo $column_amount; ?></th>
                                                <th><?php echo $column_update; ?></th>
                                                <th class="text-right"><?php echo $column_action; ?></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <th scope="row" style="vertical-align:middle"><?php echo $text_cities; ?></th>
                                                <th scope="row" style="vertical-align:middle" data-toggle="updateCities-count"><?php echo $count_cities; ?></th>
                                                <th scope="row" style="vertical-align:middle" data-toggle="updateCities-update">24.10.2016 12:42</th>
                                                <td class="text-right">
                                                    <button type="button" class="btn btn-success" id="button-updateCities" onclick="updateCities(); return false;"><?php echo $button_update_cities; ?></button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row" style="vertical-align:middle"><?php echo $text_warehouses; ?></th>
                                                <th scope="row" style="vertical-align:middle" data-toggle="updateWarehouses-count"><?php echo $count_warehouses; ?></th>
                                                <th scope="row" style="vertical-align:middle" data-toggle="updateWarehouses-update">24.10.2016 12:42</th>
                                                <td class="text-right">
                                                    <button type="button" class="btn btn-success" id="button-updateWarehouses" onclick="updateWarehouses(); return false;"><?php echo $button_update_warehouses; ?></button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 com-sm-12">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <div class="h4"><?php echo $text_settings; ?></div>
                                </div>
                                <div class="panel-body">
                                    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal" id="form-settings">
                                        <div class="form-group">
                                            <label for="input-key" class="col-sm-2 control-label"><?php echo $column_key; ?></label>
                                            <div class="col-sm-10">
                                                <input type="email" name="config_novaposhta_key" value="<?php echo $config_novaposhta_key; ?>" class="form-control" id="input-key" placeholder="<?php echo $column_key; ?>">
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="panel-footer text-right">
                                    <button type="submit" form="form-settings" class="btn btn-success"><?php echo $button_save; ?></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        var _body = $('body');

        function updateCities() {
            $.ajax({
                url: 'index.php?route=sale/novaposhta/updateCities&token=<?php echo $token; ?>',
                type: 'POST',
                dataType: 'json',
                beforeSend: function() {
                    _body.find('button').prop('disabled', true);

                    _body.find('#content > .container-fluid').prepend('<div class="alert alert-info alert-updates"><i class="fa fa-cog fa-spin"></i> <?php echo $text_updates; ?><button type="button" class="close" data-dismiss="alert">&times;</button> </div>');

                },
                complete: function() {
                    _body.find('button').prop('disabled', false);

                    _body.find('.alert-updates').remove();
                },
                success: function(json) {

                    _body.find('[data-toggle="updateCities-count"]').text(json['result']);

                    _body.find('#content > .container-fluid').prepend('<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $text_success_cities; ?><button type="button" class="close" data-dismiss="alert">&times;</button> </div>');

                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            });
        }

        function updateWarehouses() {
            $.ajax({
                url: 'index.php?route=sale/novaposhta/updateWarehouses&token=<?php echo $token; ?>',
                type: 'POST',
                dataType: 'json',
                beforeSend: function() {
                    _body.find('button').prop('disabled', true);

                    _body.find('#content > .container-fluid').prepend('<div class="alert alert-info alert-updates"><i class="fa fa-cog fa-spin"></i> <?php echo $text_updates; ?><button type="button" class="close" data-dismiss="alert">&times;</button> </div>');

                },
                complete: function() {
                    _body.find('button').prop('disabled', false);

                    _body.find('.alert-updates').remove();
                },
                success: function(json) {

                    _body.find('[data-toggle="updateWarehouses-count"]').text(json['result']);

                    _body.find('#content > .container-fluid').prepend('<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $text_success_warehouses; ?><button type="button" class="close" data-dismiss="alert">&times;</button> </div>');

                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            });
        }
    </script>

<?php echo $footer; ?>