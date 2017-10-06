<?php echo $header; ?>

<?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right"></div>
            <h1>Серии продуктов </h1>
            <ul class="breadcrumb">
                <li><a href="<?php echo $to_main; ?>"><i class="fa fa-home fa-lg"></i></a></li>
                <li><a href="<?php echo $to_series; ?>">Серии продуктов</a></li>
            </ul>
        </div>
    </div>
    <div class="container-fluid">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-list"></i> Серии продуктов</h3>
            </div>
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover">
                    <tbody>
                    <tr>
                        <td colspan="7" class="text-left">
              			<span>
              				<input class="form-control" type="name" value="" id="product_name" name="product_name" style="width: 100%;">
              				<input type="hidden" name="product_id" value="0">
              				<input type="hidden" name="series_id" value="<?php echo $series_id; ?>">
              			</span>
                        </td>
                        <td class="text-right">
              			<span>
              				<a id="addProduct" class="btn btn-success" style="width: 100%;"><i class="fa fa-plus"></i>Прикрепить</a>
              			</span>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <table class="table table-striped table-bordered table-hover tablesorter" id="myTable" >
                    <thead>
                    <tr>
                        <th class="text-center">
                            Изображение
                        </th>
                        <th class="text-center">
                            Название
                        </th>
                        <th class="text-center">
                            Артикул
                        </th>
                        <th class="text-center">
                            SKU
                        </th>
                        <th class="text-center">
                            BRAND
                        </th>
                        <th class="text-center">
                            CATEGORY
                        </th>
                        <th class="text-center">
                            Главный
                        </th>
                        <th class="text-center">
                            Действие
                        </th>
                    </thead>
                    <tbody>
                    <?php if(isset($products)) { ?>
                        <?php foreach ($products as $product) { ?>
                            <tr product-id="<?php print $product['product_id']; ?>" class="product_record">
                                <td class="text-left">
              			<span>
              				<a href="<?php print $product['href']; ?>">
              					<img src="<?php print $product['image']; ?>" />
              				</a>
              			</span>
                                </td>
                                <td class="text-left">
              			<span>
              				<a href="<?php print $product['href']; ?>">
              					<?php print $product['name']; ?>
              				</a>
              			</span>
                                </td>
                                <td class="text-left">
              			<span>
              				<a href="<?php print $product['href']; ?>">
              					<?php print $product['model']; ?>
              				</a>
              			</span>
                                </td>
                                <td class="text-left">
              			<span>
              					<?php print $product['sku']; ?>
              			</span>
                                </td>
                                <td class="text-left">
              			<span>
              					<?php print $product['manufacturer_name']; ?>
              			</span>
                                </td>
                                <td class="text-left">
              			<span>
              					<?php print $product['category']; ?>
              			</span>
                                </td>
                                <td class="text-left">
              			<span>
                                    <input type="radio" name="main_product" value="<?php print $product['product_id']; ?>" <?php if(!empty($product['is_main']) && $product['is_main']) { ?>checked="checked"<?php } ?>>
              			</span>
                                </td>
                                <td class="text-right">
                                    <span>
                                        <button data="<?php print $product['product_id']; ?>" class="btn btn-danger pull-right removeSeries" type="button"><i class="fa fa-trash-o"></i>Открепить</button>
                                    </span>
                                </td>
                            </tr>
                        <?php } ?>
                    <?php } ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function(){
        $("#myTable").tablesorter();
        // .tablesorterPager({container: $("#pager")})
        /* Autocomplete */
        $('#product_name').autocomplete({
            'source': function(request, response) {
                $.ajax({
                    url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
                    dataType: 'json',
                    success: function(json) {
                        response($.map(json, function(item) {
                            return {
                                label: item['name']+ " " + item['model'] + " " + item['sku'],
                                value: item['product_id']
                            }
                        }));
                    }
                });
            },
            'select': function(item) {
                $('#product_name').val(item.label);
                $('input[name=product_id]').val(item.value);
            }
        });

        /* Save product */
        $('#addProduct').on('click', function(){
            var product_id = $('input[name=product_id]').val();
            var series_id = $('input[name=series_id]').val();
            var data = {
                product_id: product_id,
                series_id: series_id
            };
            $.ajax({
                url: '<?php print html_entity_decode($add_product_href); ?>',
                data: data,
                dataType: 'json',
                type: 'post',
                beforeSend: function(){
                    console.log('show preloader');
                },
                complete: function(){
                    console.log('hide preloader');
                },
                success: function(response){
                    if(response.status == 'ok') {
                        setTimeout(function(){
                            window.location.reload();
                        }, 300);
                    } else {
                        alert(response.message);
                    }
                },
                error: function(e1, e2){
                    console.log(e1);
                    console.log(e2);
                }
            });

        });



        $(document).ready(function(){
            $('.removeSeries').on('click', function(e){
                var iddel = $(this).attr('data');
                confirm('Вы уверены?') ? del(iddel) : false;
            });
        });
        function del(iddel) {
            console.log(iddel);
            var series_id = <?php echo $series_id; ?>;
            var data = {
                product_id: iddel,
                series_id: series_id
            };
            $.ajax({
                url: '<?php print html_entity_decode($del_prod_href); ?>',
                dataType: 'json',
                type: 'post',
                data: data,
                beforeSend: function(){
                    console.log('show preloader');
                },
                complete: function(){
                    console.log('hide preloader');
                },
                success: function(response){
                    if(response.status == 'ok') {
                        setTimeout(function(){
                            window.location.reload();
                        }, 300);

                    } else {
                        if(response.status != 'ok') {
                            alert(response.message);
                        }
                    }
                },
                error: function(e1,e2) {
                    console.log(e1);
                    console.log(e2);
                }
            });
        }


        $('.removeProduct').on('click', function(e){
            var url = $(this).attr('href');
            confirm('Вы уверены?', function(confirm){
                if(confirm) {
                    $.ajax({
                        url: url,
                        dataType: 'json',
                        type: 'post',
                        beforeSend: function(){
                            console.log('show preloader');
                        },
                        complete: function(){
                            console.log('hide preloader');
                        },
                        success: function(response){
                            if(response.error.length == 0) {
                                if(response.message.length > 0) {
                                    $(response.message).each(function(){
                                        showSuccessMessage(this);
                                    });
                                }
                                setTimeout(function(){
                                    window.location.reload();
                                }, 1500);
                            } else {
                                $(response.error).each(function(){
                                    showErrorMessage(this);
                                });
                            }
                        },
                        error: function(e1, e2){
                            console.log(e1);
                            console.log(e2);
                        }
                    });
                }
            });

            e.preventDefault();
            return false;
        });
        $('input[name=main_product]').on('change', function(){
            if($(this).prop('checked')) {
                var product_id = $(this).val();
                var series_id  = $('input[name=series_id]').val();
                var data = {
                    product_id: product_id,
                    series_id: series_id
                };
                $.ajax({
                    url: '<?php print html_entity_decode($change_main_product_href); ?>',
                    data: data,
                    dataType: 'json',
                    type: 'post',
                    success: function(response){

                    },
                    error: function(e1, e2){
                        console.log(e1);
                        console.log(e2);
                    }
                });
            }
        });
    });
</script>
<?php echo $footer; ?>