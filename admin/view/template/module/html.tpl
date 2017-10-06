<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-html" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
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
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-html" class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
            <div class="col-sm-10">
              <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
              <?php if ($error_name) { ?>
              <div class="text-danger"><?php echo $error_name; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="tab-pane">
            <ul class="nav nav-tabs" id="language">
              <?php foreach ($languages as $language) { ?>
              <li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
              <?php } ?>
            </ul>
            <div class="tab-content">
              <?php foreach ($languages as $language) { ?>
              <div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-title<?php echo $language['language_id']; ?>"><?php echo $entry_title; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="module_description[<?php echo $language['language_id']; ?>][title]" placeholder="<?php echo $entry_title; ?>" id="input-heading<?php echo $language['language_id']; ?>" value="<?php echo isset($module_description[$language['language_id']]['title']) ? $module_description[$language['language_id']]['title'] : ''; ?>" class="form-control" />
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-description<?php echo $language['language_id']; ?>"><?php echo $entry_description; ?></label>
                  <div class="col-sm-10">
                    <textarea name="module_description[<?php echo $language['language_id']; ?>][description]" placeholder="<?php echo $entry_description; ?>" id="input-description<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($module_description[$language['language_id']]['description']) ? $module_description[$language['language_id']]['description'] : ''; ?></textarea>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-html-tpl<?php echo $language['language_id']; ?>"><span data-toggle="tooltip" title="" data-original-title="Введите название '.tpl' файла, который будет подгружен на Front. Папка для '.tpl' файлов: 'information'.">Название шаблона</span></label>
                  <div class="col-sm-10">
                    <input type="text" name="module_description[<?php echo $language['language_id']; ?>][html_tpl]" placeholder="Шаблон" id="input-html-tpl<?php echo $language['language_id']; ?>" value="<?php echo isset($module_description[$language['language_id']]['html_tpl']) ? $module_description[$language['language_id']]['html_tpl'] : ''; ?>" class="form-control" />
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-description-html<?php echo $language['language_id']; ?>">Текст для html.tpl</label>
                  <div class="col-sm-10">
                    <textarea name="module_description[<?php echo $language['language_id']; ?>][description_for_html]" placeholder="<?php echo $entry_description; ?>" id="input-description-html<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($module_description[$language['language_id']]['description_for_html']) ? $module_description[$language['language_id']]['description_for_html'] : ''; ?></textarea>
                  </div>
                </div>
                  <div class="page-header clearfix">
                    <div class="pull-right">
                      <button type="button" id="add-custom-fields-<?php echo $language['language_id']; ?>" data-count="<?php echo isset($custom_fields[$language['language_id']]) ? count($custom_fields[$language['language_id']]) : '0'; ?>" data-language="<?php echo $language['language_id']; ?>" data-toggle="tooltip" title="Добавить новое поле" class="btn btn-primary"><i class="fa fa-plus"></i></button>
                    </div>
                    <h2 class="text-left">Custom Field's <i class="fa fa-comment" style="color: red;" data-toggle="tooltip" title="Добавил новове поле, заполнил навание и выбрал тип, пересохранил. Потом уже появиться поле 'Значение'"></i></h2>
                  </div>
                  <?php $i = 1; if ( !empty($custom_fields) && !empty($custom_fields[$language['language_id']]) ) { foreach ( $custom_fields[$language['language_id']] as $custom_field ) { ?>
                  <div id="custom-field-item-<?php echo $language['language_id']; ?>-<?php echo $custom_field['id']; ?>">
                    <div class="form-group">
                      <label class="col-sm-2 control-label" for="name-custom-field-<?php echo $language['language_id']; ?>-<?php echo $custom_field['id']; ?>">Название/Тип:</label>
                      <div class="col-sm-10">
                        <div class="row">
                          <div class="col-sm-8 col-xs-12">
                            <input type="hidden"
                                   name="custom_field[<?php echo $language['language_id']; ?>][<?php echo $i; ?>][id]"
                                   value="<?php echo $custom_field['id']; ?>" />
                            <input type="text"
                                   name="custom_field[<?php echo $language['language_id']; ?>][<?php echo $i; ?>][name]"
                                   value="<?php echo strip_tags(html_entity_decode($custom_field['name'], ENT_QUOTES, 'UTF-8')); ?>"
                                   id="name-custom-field-<?php echo $language['language_id']; ?>-<?php echo $custom_field['id']; ?>"
                                   class="form-control" />
                          </div>
                          <div class="col-sm-3 col-xs-12">
                            <select class="form-control" name="custom_field[<?php echo $language['language_id']; ?>][<?php echo $i; ?>][type]">
                              <option>--Выбирите--</option>
                              <option value="text"<?php if ($custom_field['type'] == 'text' ) { echo ' selected=""'; } ?>>Текст</option>
                              <option value="textarea"<?php if ($custom_field['type'] == 'textarea' ) { echo ' selected=""'; } ?>>Текстовая область</option>
                              <option value="image"<?php if ($custom_field['type'] == 'image' ) { echo ' selected=""'; } ?>>Изображение</option>
                            </select>
                          </div>
                          <div class="col-sm-1 col-xs-12 text-right">
                            <button type="button" id="delete-custom-fields" data-id="<?php echo $custom_field['id']; ?>" data-language="<?php echo $language['language_id']; ?>" data-toggle="tooltip" title="Удалить данную группу" class="btn btn-warning"><i class="fa fa-minus"></i></button>
                          </div>
                        </div>
                      </div>
                    </div>
                    <?php if ($custom_field['type'] == 'text') { ?>
                      <div class="form-group">
                        <label class="col-sm-2 control-label" for="text-custom-field-<?php echo $language['language_id']; ?>-<?php echo $custom_field['id']; ?>">Значение:</label>
                        <div class="col-sm-10">
                          <input type="text"
                                 name="custom_field[<?php echo $language['language_id']; ?>][<?php echo $i; ?>][value]"
                                 value="<?php echo isset($custom_field['value']) ? strip_tags(html_entity_decode($custom_field['value'], ENT_QUOTES, 'UTF-8')) : ''; ?>"
                                 id="text-custom-field-<?php echo $language['language_id']; ?>-<?php echo $custom_field['id']; ?>"
                                 class="form-control" /></div>
                      </div>
                    <?php } ?>
                    <?php if ($custom_field['type'] == 'textarea') { ?>
                      <div class="form-group">
                        <label class="col-sm-2 control-label" for="textarea-custom-field-<?php echo $language['language_id']; ?>-<?php echo $custom_field['id']; ?>">Значение:</label>
                        <div class="col-sm-10">
                          <textarea rows="4"
                                    name="custom_field[<?php echo $language['language_id']; ?>][<?php echo $i; ?>][value]"
                                    id="textarea-custom-field-<?php echo $language['language_id']; ?>-<?php echo $custom_field['id']; ?>"
                                    class="form-control"><?php echo isset($custom_field['value']) ? html_entity_decode($custom_field['value'], ENT_QUOTES, 'UTF-8') : ''; ?></textarea>
                        </div>
                      </div>
                    <?php } ?>
                    <?php if ($custom_field['type'] == 'image') { ?>
                      <div class="form-group">
                        <label class="col-sm-2 control-label" for="textarea-custom-field-<?php echo $language['language_id']; ?><?php echo $custom_field['id']; ?>">Значение:</label>
                        <div class="col-sm-10">
                          <a href="" id="thumb-image-<?php echo $language['language_id']; ?>-<?php echo $custom_field['id']; ?>" data-toggle="image" class="img-thumbnail">
                            <img src="<?php echo isset($custom_field['value']) ? '/image/'.$custom_field['value'] : 'http://box-shop.lc/image/cache/no_image-100x100.png'; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" width="100" height="100" />
                          </a>
                          <input type="hidden" name="custom_field[<?php echo $language['language_id']; ?>][<?php echo $i; ?>][value]" value="<?php echo isset($custom_field['value']) ? html_entity_decode($custom_field['value'], ENT_QUOTES, 'UTF-8') : ''; ?>" id="input-image-<?php echo $language['language_id']; ?>-<?php echo $custom_field['id']; ?>" />
                        </div>
                      </div>
                    <?php } ?>
                    <hr>
                  </div>
                  <?php $i++; } } ?>
                  <div id="custom-field-<?php echo $language['language_id']; ?>"></div>
              </div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="status" id="input-status" class="form-control">
                <?php if ($status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
  <script type="text/javascript"><!--
<?php foreach ($languages as $language) { ?>
$('#input-description<?php echo $language['language_id']; ?>').summernote({height: 300});
$('#input-description-html<?php echo $language['language_id']; ?>').summernote({height: 300});
<?php if ( !empty($custom_fields) && !empty($custom_fields[$language['language_id']]) ) { ?>
    <?php foreach ( $custom_fields[$language['language_id']] as $custom_field ) { ?>
    $('#textarea-custom-field-<?php echo $language['language_id']; ?>-<?php echo $custom_field['id']; ?>').summernote({ height: 200 });
    <?php } ?>
    <?php } ?>
<?php } ?>
//--></script>
    <script type="text/javascript">
    <?php foreach ($languages as $language) { ?>
    $(document).on('click', '#add-custom-fields-<?php echo $language['language_id']; ?>', function(){
      var count     = $(this).attr('data-count'),
          language  = $(this).attr('data-language');
      addCustomFields(count, language);
    });
    <?php } ?>

    $(document).on('click', '#delete-custom-fields', function(){
      var id        = $(this).attr('data-id'),
          language  = $(this).attr('data-language');
      deleteCustomFields(id, language);
    });

    function addCustomFields(count, language) {
      if(!count) {
        count = 1;
      } else {
        count++;
        <?php foreach ($languages as $language) { ?>
        $('#add-custom-fields-<?php echo $language['language_id']; ?>').attr('data-count', count);
        <?php } ?>
      }

      var html = '';
      html += '<div id="custom-field-item-' + language + '-' + count + '">';
      html += '<div class="form-group">';
      html += '<label class="col-sm-2 control-label" for="name-custom-field-' + language + '-' + count + '">Название/Тип:</label>';
      html += '<div class="col-sm-10">';
      html += '<div class="row">';
      html += '<div class="col-sm-8 col-xs-12">';
      html += '<input type="hidden" name="custom_field[' + language + '][' + count + '][id]" value="' + count + '">';
      html += '<input type="text" name="custom_field[' + language + '][' + count + '][name]" placeholder="Название поля (латиница, через _ . Пример: same_field_1)" id="name-custom-field-' + language + '-' + count + '" class="form-control">';
      html += '</div>';
      html += '<div class="col-sm-4 col-xs-12">';
      html += '<select class="form-control" name="custom_field[' + language + '][' + count + '][type]">';
      html += '<option>--Выбирите--</option>';
      html += '<option value="text">Текст</option>';
      html += '<option value="textarea">Текстовая область</option>';
      html += '<option value="image">Изображение</option>';
      html += '</select>';
      html += '</div>';
      html += '</div>';
      html += '</div>';
      html += '</div>';
      html += '<hr>';
      html += '</div>';

      $('#custom-field-' + language).append(html);

      return true;
    }

    function deleteCustomFields (id, language) {
      $('#custom-field-item-' + language + '-' + id + '').remove();
    }

  </script>
  <script type="text/javascript"><!--
$('#language a:first').tab('show');
//--></script></div>
<?php echo $footer; ?>