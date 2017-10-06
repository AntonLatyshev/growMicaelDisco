<?php echo $header; ?><?php echo $column_left; ?>
    <div id="content">

        <div class="page-header">
            <div class="container-fluid">
                <div class="pull-right">
                    <button type="button" class="btn btn-primary" onclick="openFormSeo();"><i class="fa fa-plus"></i> <?php echo $button_add; ?></button>
                </div>
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
        </div>

        <div class="container-fluid hidden" data-toggle="form-seo">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_add; ?></h3>
                </div>
                <div class="panel-body">
                    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
                        <div class="form-group">
                            <label class="control-label col-sm-3 col-xs-12" for="seo-module-url">Введите URL</label>
                            <div class="col-sm-9 col-xs-12">
                                <input type="text" name="seo_module_url" value="<?php echo $seo_module_url; ?>" placeholder="Введите URL" id="seo-module-url" class="form-control">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-3 col-xs-12" for="seo-module-title">Meta Title</label>
                            <div class="col-sm-9 col-xs-12">
                                <input type="text" name="seo_module_title" value="<?php echo $seo_module_title; ?>" placeholder="Введите Meta Title" id="seo-module-title" class="form-control">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 col-xs-12 control-label" for="seo-module-desc">Meta Description</label>
                            <div class="col-sm-9 col-xs-12">
                                <textarea name="seo_module_desc" rows="3" placeholder="Введите Meta Description" id="seo-module-desc" class="form-control"><?php echo $seo_module_desc; ?></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 col-xs-12 control-label" for="seo-module-keyword">Meta Keyword</label>
                            <div class="col-sm-9 col-xs-12">
                                <textarea name="seo_module_keyword" rows="3" placeholder="Введите Meta Keyword" id="seo-module-keyword" class="form-control"><?php echo $seo_module_keyword; ?></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-3 col-xs-12" for="seo-module-h1">Введите H1</label>
                            <div class="col-sm-9 col-xs-12">
                                <input type="text" name="seo_module_h1" value="<?php echo $seo_module_h1; ?>" placeholder="Введите H1" id="seo-module-h1" class="form-control">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 col-xs-12 control-label" for="seo-module-text">Текст</label>
                            <div class="col-sm-9 col-xs-12">
                                <textarea name="seo_module_text" rows="5" placeholder="Введите текст" id="seo-module-text" class="form-control"><?php echo $seo_module_text; ?></textarea>
                            </div>
                        </div>
                        <div class="button text-right">
                            <button type="submit" form="form" class="btn btn-success"><i class="fa fa-save"></i> Сохранить</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="container-fluid">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
                </div>
                <div class="panel-body">
                    <div class="well">
                        <div class="row">
                            <div class="col-md-10 col-sm-9 col-sm-12">
                                <div class="form-group">
                                    <label class="control-label" for="input-name"><?php echo $entry_filter; ?></label>
                                    <input type="text" name="filter_name" value="<?php echo $filter_name; ?>" placeholder="<?php echo $entry_filter; ?>" class="form-control" />
                                </div>
                            </div>
                            <div class="col-md-2 col-xs-3 col-xs-12">
                                <label class="control-label" for="button-filter_seo">&nbsp;</label>
                                <button type="button" id="button-filter_seo" class="btn btn-primary btn-block"><i class="fa fa-search"></i> <?php echo $button_filter; ?></button>
                            </div>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <td style="width:40px">#</td>
                                    <td><?php echo $column_url; ?></td>
                                    <td><?php echo $column_h1; ?></td>
                                    <td class="text-right" style="width:96px"><?php echo $column_action; ?></td>
                                </tr>
                            </thead>
                            <tbody>
                            <?php if ($all_data) { ?>
                                <?php foreach ($all_data as $data) { ?>
                                    <tr>
                                        <td><?php echo $data['seo_mobule_link']; ?></td>
                                        <td><strong><?php echo $data['seo_url']; ?></strong></td>
                                        <td><strong><?php echo $data['seo_h1']; ?></strong></td>
                                        <td class="text-right">
                                            <button class="btn btn-primary" data-id="<?php echo $data['seo_mobule_link']; ?>" data-action="seo-edit"><i class="fa fa-pencil"></i></button>
                                            <button class="btn btn-danger deleter" linkid="<?php echo $data['seo_mobule_link']; ?>"><i class="fa fa-trash-o"></i></button>
                                        </td>
                                    </tr>
                                <?php } ?>
                            <?php } else { ?>
                                <tr>
                                    <td class="text-center" colspan="4"><?php echo $text_no_results; ?></td>
                                </tr>
                            <?php } ?>
                            </tbody>
                        </table>
                    </div>
                    <div class="row">
                        <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
                        <div class="col-sm-6 text-right"><?php echo $results; ?></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        var body = $('body');

        function openFormSeo() {
            body.find('[data-toggle="form-seo"]').toggleClass('hidden');
        }

        $('#seo-module-text').summernote({height: 200});

        $('#button-filter_seo').on('click', function () {
            var url = 'index.php?route=tool/seo_titles&token=<?php echo $token; ?>';

            var filter_name = $('input[name=\'filter_name\']').val();

            if (filter_name) {
                url += '&filter_name=' + encodeURIComponent(filter_name);
            }

            location = url;
        });

        $(document).on("click", ".deleter", function () {
            var currentLinkId = parseInt($(this).attr('linkid'));

            var data = {
                seo_id: currentLinkId
            };

            $.ajax({
                url: 'index.php?route=tool/seo_titles/deleter&token=<?php echo $token; ?>',
                type: 'post',
                data: data,
                success: function () {
                    location.reload();
                }
            });
        });
    </script>
<?php echo $footer; ?>