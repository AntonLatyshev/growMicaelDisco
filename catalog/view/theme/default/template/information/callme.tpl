<div id="callBack" style="display: none;" data-loaded="1">
    <div class="bootbox modal fade bootbox-alert in" tabindex="-1" role="dialog" aria-hidden="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" id="callback-buttonclose" class="bootbox-close-button close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times"></i></button>
                </div>
                <div class="modal-body">
                    <div class="bootbox-body">
                        <form action="">
                            <div class="heading"><span><?php echo $entry_title_call; ?></span></div>
                            <div class="after-heading"><?php echo $entry_text_call; ?></div>
                            <fieldset>
                                <div class="form-group required row">
                                    <div class="col-sm-12">
                                        <input type="text" name="name" value="" id="callback-name" class="form-control default" placeholder="<?php echo $entry_name; ?>" />
                                    </div>
                                </div>
                                <div class="form-group required row">
                                    <div class="col-sm-12">
                                        <input type="text" name="phone" value="" id="callback-phone" class="form-control default" placeholder="+38 (0XX) XX-XX-XXX" />
                                    </div>
                                    <script>
                                        $('#callback-phone').mask('+38 (099) 999-99-99');
                                        $(document).ready(function(){
                                            $('#callback-phone').mask('+38 (099) 999-99-99');
                                        });
                                    </script>
                                </div>
                                <div class="form-group nore row">
                                    <div class="col-sm-12">
                                        <textarea name="comment" rows="5" id="callback-comment" class="form-control default" placeholder="<?php echo $entry_comment; ?>"></textarea>
                                    </div>
                                </div>

                            </fieldset>
                        </form>
                    </div>
                </div>
                <div class="modal-footer">
                    <button data-bb-handler="ok" id="callback-submit" type="button" class="btn btn-primary"><?php echo $entry_send; ?></button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal-backdrop fade in"></div>
</div>