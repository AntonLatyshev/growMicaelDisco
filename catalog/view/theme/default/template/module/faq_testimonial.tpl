<?php if ($topics) { ?>
    <?php $i = 0; $c = count($topics); foreach ($topics as $topic) { ?>
        <div class="cd-faq" id="faq-<?php echo $i; ?>">
            <div class="row">
                <div class="col-lg-5 col-md-5 col-sm-12">
                    <div class="h3 faq-topic"><?php echo $topic['name']; ?>:</div>
                </div>
                <div class="faq-items faq-items-<?php echo $i; ?> col-lg-7 col-md-7 col-sm-12">
                    <?php if ($topic['faqs']) { ?>
                        <?php foreach ($topic['faqs'] as $faq) { ?>
                            <div class="faq-item--request" aria-expanded="true" aria-selected="true"><?php echo $faq['title']; ?></div>
                            <div class="faq-item--response">
                                <?php echo $faq['description']; ?>
                            </div>
                        <?php } ?>
                    <?php } else { ?>
                        <p class="text-empty"><?php echo $text_empty; ?></p>
                    <?php } ?>
                </div>
            </div>
        </div>
    <?php $i++; } ?>
<?php } ?>
<script>
    $(function() {

        if (getFaqKey()) {
            console.log(1);
            var _key = parseInt(getFaqKey());

            $(".faq-items-"+_key).accordion({
                active: false,
                collapsible: true,
                heightStyle: "content"
            });

            <?php for ($count = 0; $count <= $c; $count++) { if ($count == $faq_key) { continue; } ?>
            $(".faq-items-<?php echo $count; ?>").accordion({
                active: false,
                collapsible: true,
                heightStyle: "content"
            });
            <?php } ?>

        }

        if (!getFaqKey()) {
            console.log(2);
            $(".faq-items-0").accordion({
                active: false,
                collapsible: true,
                heightStyle: "content"
            });
            <?php for ($count = 1; $count <= $c; $count++) { ?>
            $(".faq-items-<?php echo $count; ?>").accordion({
                active: false,
                collapsible: true,
                heightStyle: "content"
            });
            <?php } ?>
        }
    });
</script>