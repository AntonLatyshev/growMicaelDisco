<div class="step-heading">
    <span class="number">2</span>
    <span class="label"><?php echo $text_heading; ?></span>
</div>
<div class="step-hidden delivery">
    <div class="col col-1">
        <span class="label-text"><?php echo $text_delivery; ?></span>
        <div class="info">i
            <div class="info-content"><?php echo $text_info_delivery; ?></div>
        </div>
    </div>
    <div class="col col-2" id="shipping_methods">
        <?php /* ?>
        <div class="row">
            <label for="our-store">
                <input type="radio" name="delivery" id="our-store">
                <span>Из нашего магазина  (бесплатно)</span>
            </label>
        </div>
        <div class="select" data-radio="our-store">
            <div class="row">
                <select name="" id="">
                    <option value="1">Склад №1, Пушкинская, 51</option>
                    <option value="1">Склад №2, Пушкинская, 52</option>
                    <option value="1">Склад №3, Пушкинская, 53</option>
                </select>
            </div>
        </div>
        <div class="row">
            <label for="np">
                <input type="radio" name="delivery" id="np">
                <span>Из отделения «Новой Почты»  (35 грн)</span>
            </label>
        </div>
        <div class="select" data-radio="np">
            <div class="row">
                <select>
                    <option value="1">Харьков</option>
                    <option value="1">Киев</option>
                    <option value="1">Склад №3, Пушкинская, 53</option>
                </select>
            </div>
            <div class="row">
                <select>
                    <option value="1">Склад №3, Пушкинская, 53</option>
                </select>
            </div>
        </div>
        <div class="row">
            <label for="curier">
                <input type="radio" name="delivery" id="curier">
                <span>Курьером по адресу  (80 грн)</span>
            </label>
        </div>
        <div class="select" data-radio="curier">
            <div class="row address">
                <div class="input-row">
                    <input type="text" placeholder="Улица">
                </div>
                <div class="input-row double">
                    <input type="text" placeholder="Дом">
                    <input type="text" placeholder="Квартира">
                </div>
            </div>
        </div>
        <?php */ ?>
    </div>
</div>
<div class="step-hidden pay-type">
    <div class="col col-1">
        <span class="label-text"><?php echo $text_payment; ?></span>
        <div class="info">i
            <div class="info-content"><?php echo $text_info_payment; ?></div>
        </div>
    </div>
    <div class="col col-2" id="payment_methods">
        <?php /* ?>
        <div class="row">
            <label for="cashe">
                <input type="radio" name="pay-type" id="cashe">
                <span>Наличными</span>
            </label>
        </div>
        <div class="row">
            <label for="not-cash">
                <input type="radio" name="pay-type" id="not-cash">
                <span>Безналичными</span>
            </label>
        </div>
        <?php */ ?>
    </div>
</div>
<div class="step-hidden comment">
    <div class="col-1"></div>
    <div class="col-2">
        <label for="comment">
            <span class="comment-handler"><?php echo $text_comments; ?></span>
            <div class="info">i
                <div class="info-content"><?php echo $text_info_comments; ?></div>
            </div>
        </label>
        <textarea name="comment" id="comment" cols="30" rows="10"><?php echo $comment; ?></textarea>
    </div>
</div>