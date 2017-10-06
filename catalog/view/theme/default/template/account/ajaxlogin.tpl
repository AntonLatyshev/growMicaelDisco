<div id="ajaxPage" style="display: none;" data-loaded="1">
  <div class="bootbox modal fade bootbox-alert in" tabindex="-1" role="dialog" aria-hidden="false">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" id="callback-buttonclose" class="bootbox-close-button close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times"></i></button>
        </div>
        <div class="modal-body">
          <div class="bootbox-body">
            <h2><?php echo $text_i_am_returning_customer; ?></h2>
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="ajax2login">
              <div class="form-group">
                <label class="control-label" for="input-email"><?php echo $entry_email; ?></label>
                <input type="text" name="email" value="<?php echo $email; ?>" id="input-email" class="form-control" />
              </div>
              <div class="form-group">
                <label class="control-label" for="input-password"><?php echo $entry_password; ?></label>
                <input type="password" name="password" value="<?php echo $password; ?>" id="input-password" class="form-control" />
                <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a></div>
              <input type="submit" value="<?php echo $button_login; ?>" class="btn btn-primary" />
              <?php if ($redirect) { ?>
                <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
              <?php } ?>
            </form>
          </div>
        </div>
        <div class="modal-footer">
          <button data-bb-handler="ok" id="ajaxPage-submit" type="button" class="btn btn-primary"><?php echo $entry_send; ?></button>
        </div>
      </div>
    </div>
  </div>
  <div class="modal-backdrop fade in"></div>
</div>