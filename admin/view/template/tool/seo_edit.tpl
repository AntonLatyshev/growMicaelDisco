<div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" id="exampleModalLabel">Редактирование записи</h4>
        </div>
        <div class="modal-body">
            <form enctype="multipart/form-data" id="form-seo" class="form-horizontal">
                <div class="form-group">
                    <label for="seo-url" class="control-label col-sm-2">Ссылка:</label>
                    <div class="col-sm-10">
                        <input name="seo_url" id="seo-url" type="text" class="form-control" value="<?php echo $seo_url; ?>" placeholder="Ссылка" />
                    </div>
                </div>
                <hr>
                <div class="form-group">
                    <label for="seo-title" class="control-label col-sm-2">Meta Title:</label>
                    <div class="col-sm-10">
                        <input name="seo_title" id="seo-title" type="text" class="form-control" value="<?php echo $seo_title; ?>" placeholder="Meta Title" />
                        <?php /* foreach ($languages as $language) { ?>
                            <div class="input-group"><span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
                                <input type="text" name="seo_description[<?php echo $language['language_id']; ?>][meta_title]" value="<?php echo isset($seo_description[$language['language_id']]) ? $seo_description[$language['language_id']]['meta_title'] : ''; ?>" placeholder="Meta Title" class="form-control" />
                            </div>
                        <?php } */ ?>
                    </div>
                </div>
                <hr>
                <div class="form-group">
                    <label for="seo-desc" class="control-label col-sm-2">Meta Description:</label>
                    <div class="col-sm-10">
                        <textarea name="seo_desc" id="seo-desc" rows="2" class="form-control" placeholder="Meta Description"><?php echo html_entity_decode($data['seo_desc']); ?></textarea>
                        <?php /* foreach ($languages as $language) { ?>
                            <div class="input-group"><span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
                                <textarea name="seo_description[<?php echo $language['language_id']; ?>][meta_description]" rows="5" placeholder="Meta Description" id="input-meta-description<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($seo_description[$language['language_id']]) ? $seo_description[$language['language_id']]['meta_description'] : ''; ?></textarea>
                            </div>
                        <?php } */?>
                    </div>
                </div>
                <hr>
                <div class="form-group">
                    <label for="seo-keyword" class="control-label col-sm-2">Meta Keyword:</label>
                    <div class="col-sm-10">
                        <textarea name="seo_keyword" id="seo-keyword" rows="2" class="form-control" placeholder="Meta Keyword"><?php echo html_entity_decode($data['seo_keyword']); ?></textarea>
                        <?php /* foreach ($languages as $language) { ?>
                            <div class="input-group"><span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
                                <textarea name="seo_description[<?php echo $language['language_id']; ?>][meta_description]" rows="5" placeholder="Meta Description" id="input-meta-description<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($seo_description[$language['language_id']]) ? $seo_description[$language['language_id']]['meta_description'] : ''; ?></textarea>
                            </div>
                        <?php } */?>
                    </div>
                </div>
                <hr>
                <div class="form-group">
                    <label for="seo-h1" class="control-label col-sm-2">Заголовок:</label>
                    <div class="col-sm-10">
                        <input name="seo_h1" id="seo-h1" type="text" class="form-control" value="<?php echo $seo_h1; ?>" placeholder="Заголовок" />
                        <?php /* foreach ($languages as $language) { ?>
                            <div class="input-group"><span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
                                <input type="text" name="seo_description[<?php echo $language['language_id']; ?>][h1]" value="<?php echo isset($seo_description[$language['language_id']]) ? $seo_description[$language['language_id']]['h1'] : ''; ?>" placeholder="Заголовок" class="form-control" />
                            </div>
                        <?php } */?>
                    </div>
                </div>
                <hr>
                <div class="form-group">
                    <label for="seo-text" class="control-label col-sm-2">Описание:</label>
                    <div class="col-sm-10">
                        <textarea name="seo_text" id="seo-text" rows="3" class="form-control" placeholder="Описание"><?php echo html_entity_decode($data['seo_text']); ?></textarea>
                        <?php /* foreach ($languages as $language) { ?>
                            <div class="input-group"><span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
                                <textarea name="seo_description[<?php echo $language['language_id']; ?>][text]" rows="5" placeholder="Описание" id="input-meta-description<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($seo_description[$language['language_id']]) ? $seo_description[$language['language_id']]['text'] : ''; ?></textarea>
                            </div>
                        <?php } */ ?>
                    </div>
                </div>
            </form>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
            <button type="button" onclick="editSEO(); return false;" class="btn btn-primary">Сохранить</button>
        </div>
    </div>
</div>

<script type="text/javascript">
    $('#seo-text').summernote({height: 150});

    function editSEO() {
        var _modal = $('#modal-seo');

        $('textarea[name="seo_text"]').html($('#seo-text').code());

        _modal.find('.alert').remove();
        _modal.find('.form-group').removeClass('has-error');

        $.ajax({
            url: '<?php echo $action; ?><?php echo ( !empty($seo_id) ) ? '&seo_id=' . $seo_id : ''; ?>&token=<?php echo $token; ?>',
            type: 'post',
            dataType: 'json',
            data: new FormData($('#form-seo')[0]),
            cache: false,
            contentType: false,
            processData: false,
            success: function(json) {

                if (json['error']) {
                    $.each(json['error'], function (key, value) {
                        _modal.find('[name="' + key + '"]')
                            .parent().parent()
                            .addClass('has-error')
                            .after('<p class="alert alert-danger">'+ value +'<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></p>');
                    });

                }

                if (json['success']) {
                    $('#modal-seo').modal('hide');
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }
</script>
