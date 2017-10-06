<?php

class ControllerProductProduct extends Controller
{
    private $error = array();

    public function fastBuyPhone()
    {

        $fb_phone = $this->request->post['phone_fast'];


        $prd_id = (int)$this->request->post['product_id'];
        $this->load->model('catalog/product');
        $prd_info = $this->model_catalog_product->getProduct($prd_id);
        $fastBuyProductId = $prd_info['product_id'];
        $fastBuyProductName = $prd_info['name'];
        $fastBuyProductModel = $prd_info['model'];
        $fastBuyProductQuantity = (int)1;
        $fastBuyProductPrice = $prd_info['price'];
        $fastBuyProductTotal = $prd_info['price'] * $fastBuyProductQuantity;
        $fastBuyProductReward = 0;


        $currentDate = date("Y-m-d H:i:s");
        $status = (int)1;
        //fast-buy VARRIBLE start
        $firstName = "FAST ORDER BY PHONE";
        $fastOrder = "FAST ORDER BY PHONE";
        $fastCommentary = "FAST ORDER BY PHONE";
        $fastEmail = "test@mail.cc";
        $fastEmail = trim($fastEmail);
        $fastAddress = "Test Adress";
        $fastCity = "Test City";
        $fastCountryId = (int)220;
        $fastZoneId = (int)4224;
        $fastPaymentMethod = "Cash On Delivery";
        $fastPaymentCode = "cod";
        $fastShippingMethod = "Flat Shipping Rate";
        $fastShippingCode = "free.free";
        //fast-buy VARRIBLE end


        $this->db->query("INSERT INTO " . DB_PREFIX . "order SET firstname = '" . $firstName . "'
                                                        , lastname = '" . $fastOrder . "'
                                                        , payment_firstname = '" . $firstName . "'
                                                        , payment_lastname = '" . $firstName . "'
                                                        , payment_address_1 = '" . $fastAddress . "'
                                                        , payment_city = '" . $fastCity . "'
                                                        , payment_country_id = '" . $fastCountryId . "'
                                                        , payment_zone_id = '" . $fastZoneId . "'
                                                        , payment_method = '" . $fastShippingMethod . "'
                                                        , payment_code = '" . $fastPaymentCode . "'
                                                        , shipping_firstname = '" . $firstName . "'
                                                        , shipping_lastname = '" . $firstName . "'
                                                        , shipping_address_1 = '" . $fastAddress . "'
                                                        , shipping_city = '" . $fastCity . "'
                                                        , shipping_country_id = '" . $fastCountryId . "'
                                                        , shipping_zone_id = '" . $fastZoneId . "'
                                                        , shipping_method = '" . $fastPaymentMethod . "'
                                                        , shipping_code = '" . $fastShippingCode . "'
                                                        , email = '" . $fastEmail . "'
                                                        , telephone = '" . $fb_phone . "'
                                                        , total = '" . $fastBuyProductTotal . "'
                                                        , date_added = '" . $currentDate . "'
                                                        , date_modified = '" . $currentDate . "'
                                                        , order_status_id = '" . $status . "'
                                                        , comment = '" . $fastCommentary . "'");

        $order_id = $this->db->getLastId();

        $this->db->query("INSERT INTO " . DB_PREFIX . "order_product SET product_id = '" . $fastBuyProductId . "'
                                                        , order_id = '" . $order_id . "'
                                                        , name = '" . $fastBuyProductName . "'
                                                        , model = '" . $fastBuyProductModel . "'
                                                        , quantity = '" . $fastBuyProductQuantity . "'
                                                        , price = '" . $fastBuyProductPrice . "'
                                                        , total = '" . $fastBuyProductTotal . "'
                                                        , reward = '" . $fastBuyProductReward . "'");

        $mail = new Mail();
        $mail->protocol = $this->config->get('config_mail_protocol');
        $mail->parameter = $this->config->get('config_mail_parameter');
        $mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
        $mail->smtp_username = $this->config->get('config_mail_smtp_username');
        $mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
        $mail->smtp_port = $this->config->get('config_mail_smtp_port');
        $mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

        $mail->setTo($this->config->get('config_email'));
        $mail->setFrom($this->config->get('config_email'));
        $mail->setSender($this->config->get('config_name'));
        $mail->setSubject(html_entity_decode('Быстрый заказ'));
        $mail->setHTML('<p>Вы получили новый заказ.</p> <p>Товар: ' . $prd_info['name'] . '</p> <p>Номер телефона клиента: ' . $this->request->post['phone_fast'] . '</p>');
        $mail->send();
    }

    protected function getPath($parent_id, $current_path = '')
    {

        $this->load->model('catalog/category');

        $category_info = $this->model_catalog_category->getCategory($parent_id);

        if ($category_info) {
            if (!$current_path) {
                $new_path = $category_info['category_id'];
            } else {
                $new_path = $category_info['category_id'] . '_' . $current_path;
            }

            $path = $this->getPath($category_info['parent_id'], $new_path);

            if ($path) {
                return $path;
            } else {
                return $new_path;
            }
        }
    }

    protected function getTrueUrl($product_id)
    {
        $categories = $this->model_catalog_product->getCategoriesByProductId($product_id);

        if ($categories) {

            foreach ($categories as $category) {
                $path_true = $this->getPath($category['category_id']);
                $category_info = $this->model_catalog_category->getCategory($category['category_id']);

                if ($path_true) {
                    $cat_path = $path_true;
                } else {
                    $cat_path = $category_info['category_id'];
                }

                if ($category_info) {
                    $path_true = '';

                    foreach (explode('_', $cat_path) as $path_true_id) {

                        if (!$path_true) {
                            $path_true = $path_true_id;
                        } else {
                            $path_true .= '_' . $path_true_id;
                        }

                        $category_info = $this->model_catalog_category->getCategory($path_true_id);

                        if ($category_info) {
                            $data['breadcrumbs'][] = array(
                                'text' => $category_info['name'],
                                'href' => $this->url->link('product/category', '&path=' . $path_true),
                                'separator' => $this->language->get('text_separator')
                            );
                        }
                    }
                    break;
                }

            }

            return $path_true;

        }

    }

    public function index()
    {
        $this->load->language('product/product');

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home')
        );

        // Insert model
        $this->load->model('catalog/manufacturer');

        $this->load->model('catalog/category');

        $this->load->model('catalog/product');

        $data['isXhr'] = $this->request->isXhr();

        $path = '';

        if (isset($this->request->get['path'])) {

            $parts = explode('_', (string)$this->request->get['path']);
            $k = count($parts) - 1;
            $category_id = $parts[$k];

            foreach ($parts as $path_id) {
                if (!$path) {
                    $path = $path_id;
                } else {
                    $path .= '_' . $path_id;
                }

                $category_info = $this->model_catalog_category->getCategory($path_id);

                if ($category_info) {
                    $data['breadcrumbs'][] = array(
                        'text' => $category_info['name'],
                        'href' => $this->url->link('product/category', 'path=' . $path)
                    );
                }
            }

            // Set the last category breadcrumb
            $category_info = $this->model_catalog_category->getCategory($category_id);

            if ($category_info) {
                $url = '';

                if (isset($this->request->get['sort'])) {
                    $url .= '&sort=' . $this->request->get['sort'];
                }

                if (isset($this->request->get['order'])) {
                    $url .= '&order=' . $this->request->get['order'];
                }

                if (isset($this->request->get['page'])) {
                    $url .= '&page=' . $this->request->get['page'];
                }

                if (isset($this->request->get['limit'])) {
                    $url .= '&limit=' . $this->request->get['limit'];
                }

//				$data['breadcrumbs'][] = array(
//					'text' => $category_info['name'],
//					'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url)
//				);
            }
        }

        // Fixed SEO url
        $path_true = $this->getTrueUrl((int)$this->request->get['product_id']);

        if (array_key_exists('search', $this->request->get)) {

        } elseif (array_key_exists('manufacturer_id', $this->request->get)) {

        } elseif (array_key_exists('path', $this->request->get)) {
            if (!empty($path_true)) {
                if ($path != $path_true) {
                    $this->response->redirect($this->url->link('product/product', '&path=' . $path_true . '&product_id=' . $this->request->get['product_id']), '301');
                }
            }
        } else {
            if (!empty($path_true)) {
                if ($path != $path_true) {
                    $this->response->redirect($this->url->link('product/product', '&path=' . $path_true . '&product_id=' . $this->request->get['product_id']), '301');
                }
            }
        }

        if (isset($this->request->get['manufacturer_id'])) {
            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_brand'),
                'href' => $this->url->link('product/manufacturer')
            );

            $url = '';

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            if (isset($this->request->get['limit'])) {
                $url .= '&limit=' . $this->request->get['limit'];
            }

            $manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($this->request->get['manufacturer_id']);

            if ($manufacturer_info) {
                $data['breadcrumbs'][] = array(
                    'text' => $manufacturer_info['name'],
                    'href' => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] . $url)
                );
            }
        }

        if (isset($this->request->get['search']) || isset($this->request->get['tag'])) {
            $url = '';

            if (isset($this->request->get['search'])) {
                $url .= '&search=' . $this->request->get['search'];
            }

            if (isset($this->request->get['tag'])) {
                $url .= '&tag=' . $this->request->get['tag'];
            }

            if (isset($this->request->get['description'])) {
                $url .= '&description=' . $this->request->get['description'];
            }

            if (isset($this->request->get['category_id'])) {
                $url .= '&category_id=' . $this->request->get['category_id'];
            }

            if (isset($this->request->get['sub_category'])) {
                $url .= '&sub_category=' . $this->request->get['sub_category'];
            }

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            if (isset($this->request->get['limit'])) {
                $url .= '&limit=' . $this->request->get['limit'];
            }

            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_search'),
                'href' => $this->url->link('product/search', $url)
            );
        }

        if (isset($this->request->get['product_id'])) {
            $product_id = (int)$this->request->get['product_id'];
        } else {
            $product_id = 0;
        }

        $product_info = $this->model_catalog_product->getProduct($product_id);

        /*code start*/
        if ((strtotime(date('Y-m-d')) >= strtotime($product_info['promo_date_start'])) && (strtotime(date('Y-m-d')) <= strtotime($product_info['promo_date_end'])) || (($product_info['promo_date_start'] == '0000-00-00') && ($product_info['promo_date_end'] == '0000-00-00'))) {
            $promo_on = TRUE;
        } else {
            $promo_on = FALSE;
        }
        /*code end*/

        if ($product_info) {
            $url = '';

            if (isset($this->request->get['path'])) {
                $url .= '&path=' . $this->request->get['path'];
            }

            if (isset($this->request->get['filter'])) {
                $url .= '&filter=' . $this->request->get['filter'];
            }

            if (isset($this->request->get['manufacturer_id'])) {
                $url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
            }

            if (isset($this->request->get['search'])) {
                $url .= '&search=' . $this->request->get['search'];
            }

            if (isset($this->request->get['tag'])) {
                $url .= '&tag=' . $this->request->get['tag'];
            }

            if (isset($this->request->get['description'])) {
                $url .= '&description=' . $this->request->get['description'];
            }

            if (isset($this->request->get['category_id'])) {
                $url .= '&category_id=' . $this->request->get['category_id'];
            }

            if (isset($this->request->get['sub_category'])) {
                $url .= '&sub_category=' . $this->request->get['sub_category'];
            }

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            if (isset($this->request->get['limit'])) {
                $url .= '&limit=' . $this->request->get['limit'];
            }

            $data['breadcrumbs'][] = array(
                'text' => $product_info['name'],
                'href' => $this->url->link('product/product', $url . '&product_id=' . $this->request->get['product_id'])
            );

            $this->document->setTitle($product_info['meta_title']);
            $this->document->setDescription($product_info['meta_description']);
            $this->document->setKeywords($product_info['meta_keyword']);
            $this->document->addLink($this->url->link('product/product', 'path=' . $path_true . '&product_id=' . $this->request->get['product_id']), 'canonical');

            // Blueimp style
            $this->document->addStyle('catalog/view/theme/default/stylesheet/blueimp/blueimp-gallery.css');
            $this->document->addStyle('catalog/view/theme/default/stylesheet/blueimp/blueimp-gallery-indicator.css');

            // Blueimp script
            $this->document->addScript('catalog/view/javascript/blueimp/blueimp-gallery.js');
            $this->document->addScript('catalog/view/javascript/blueimp/blueimp-gallery-fullscreen.js');
            $this->document->addScript('catalog/view/javascript/blueimp/blueimp-gallery-indicator.js');
            $this->document->addScript('catalog/view/javascript/blueimp/jquery.blueimp-gallery.js');

            $data['heading_title'] = $product_info['name'];

            $data['text_select'] = $this->language->get('text_select');
            $data['text_manufacturer'] = $this->language->get('text_manufacturer');
            $data['text_model'] = $this->language->get('text_model');
            $data['text_reward'] = $this->language->get('text_reward');
            $data['text_points'] = $this->language->get('text_points');
            $data['text_stock'] = $this->language->get('text_stock');
            $data['text_discount'] = $this->language->get('text_discount');
            $data['text_tax'] = $this->language->get('text_tax');
            $data['text_option'] = $this->language->get('text_option');
            $data['text_minimum'] = sprintf($this->language->get('text_minimum'), $product_info['minimum']);
            $data['text_write'] = $this->language->get('text_write');
            $data['text_login'] = sprintf($this->language->get('text_login'), $this->url->link('account/login', '', 'SSL'), $this->url->link('account/register', '', 'SSL'));
            $data['text_note'] = $this->language->get('text_note');
            $data['text_tags'] = $this->language->get('text_tags');
            $data['text_related'] = $this->language->get('text_related');
            $data['text_loading'] = $this->language->get('text_loading');

            $data['entry_qty'] = $this->language->get('entry_qty');
            $data['entry_name'] = $this->language->get('entry_name');
            $data['entry_review'] = $this->language->get('entry_review');
            $data['entry_rating'] = $this->language->get('entry_rating');
            $data['entry_good'] = $this->language->get('entry_good');
            $data['entry_bad'] = $this->language->get('entry_bad');

            $data['button_cart'] = $this->language->get('button_cart');
            $data['button_wishlist'] = $this->language->get('button_wishlist');
            $data['button_compare'] = $this->language->get('button_compare');
            $data['button_upload'] = $this->language->get('button_upload');
            $data['button_continue'] = $this->language->get('button_continue');

            $this->load->model('catalog/review');

            $data['tab_description'] = $this->language->get('tab_description');
            $data['tab_attribute'] = $this->language->get('tab_attribute');
            $data['tab_review'] = sprintf($this->language->get('tab_review'), $product_info['reviews']);

            $data['product_id'] = (int)$this->request->get['product_id'];
            $data['manufacturer'] = $product_info['manufacturer'];
            $data['manufacturers'] = $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $product_info['manufacturer_id']);
            $data['model'] = $product_info['model'];
            $data['reward'] = $product_info['reward'];
            $data['points'] = $product_info['points'];

            /* In cart */
            $cart_products = $this->cart->getProducts();
            $cart_ids = array();
            if(is_array($cart_products) && !empty($cart_products)) {
                foreach ($cart_products as $cart_product) {
                    $cart_ids[] = $cart_product['product_id'];
                }
                array_unique($cart_ids);
            }

            $wish_list = (!empty($this->session->data['wishlist'])) ? $this->session->data['wishlist'] : array();

            $data['button_cart']       = (in_array($product_info['product_id'], $cart_ids)) ? $this->language->get('button_in_cart') : $this->language->get('button_cart');
            $data['in_cart']           = (in_array($product_info['product_id'], $cart_ids)) ? true : false;
            $data['button_wishlist']   = (in_array($product_info['product_id'], $wish_list)) ? $this->language->get('button_in_wishlist') : 'Добавить в желаемое';
            $data['in_wishlist']       = (in_array($product_info['product_id'], $wish_list)) ? true : false;

            if ($product_info['quantity'] <= 0) {
                $data['stock'] = $product_info['stock_status'];
            } elseif ($this->config->get('config_stock_display')) {
                $data['stock'] = $product_info['quantity'];
            } else {
                $data['stock'] = $this->language->get('text_instock');
            }

            $this->load->model('tool/image');

            if ($product_info['image']) {
                $data['popup'] = $this->model_tool_image->resize($product_info['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height'));
            } else {
                $data['popup'] = '';
            }

            if ($product_info['image']) {
                $data['thumb'] = $this->model_tool_image->resize($product_info['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'));
            } else {
                $data['thumb'] = '';
            }

            $data['images'] = array();

            $results = $this->model_catalog_product->getProductImages($this->request->get['product_id']);

            foreach ($results as $result) {
                $data['images'][] = array(
                    'popup' => $this->model_tool_image->resize($result['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height')),
                    'thumb' => $this->model_tool_image->resize($result['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height'))
                );
            }

            if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                $data['price'] = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
            } else {
                $data['price'] = false;
            }

            if ((float)$product_info['special']) {
                $data['special'] = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
            } else {
                $data['special'] = false;
            }

            if ($this->config->get('config_tax')) {
                $data['tax'] = $this->currency->format((float)$product_info['special'] ? $product_info['special'] : $product_info['price']);
            } else {
                $data['tax'] = false;
            }

            $discounts = $this->model_catalog_product->getProductDiscounts($this->request->get['product_id']);

            $data['discounts'] = array();

            foreach ($discounts as $discount) {
                $data['discounts'][] = array(
                    'quantity' => $discount['quantity'],
                    'price' => $this->currency->format($this->tax->calculate($discount['price'], $product_info['tax_class_id'], $this->config->get('config_tax')))
                );
            }

            $data['price_value'] = $product_info['price'];
            $data['special_value'] = $product_info['special'];
            $data['tax_value'] = (float)$product_info['special'] ? $product_info['special'] : $product_info['price'];

            $var_currency = array();
            $var_currency['value'] = $this->currency->getValue();
            $var_currency['symbol_left'] = $this->currency->getSymbolLeft();
            $var_currency['symbol_right'] = $this->currency->getSymbolRight();
            $var_currency['decimals'] = $this->currency->getDecimalPlace();
            $var_currency['decimal_point'] = $this->language->get('decimal_point');
            $var_currency['thousand_point'] = $this->language->get('thousand_point');
            $data['currency'] = $var_currency;

            $data['dicounts_unf'] = $discounts;

            $data['tax_class_id'] = $product_info['tax_class_id'];
            $data['tax_rates'] = $this->tax->getRates(0, $product_info['tax_class_id']);

            $data['options'] = array();

            foreach ($this->model_catalog_product->getProductOptions($this->request->get['product_id']) as $option) {
                // Skip Option if disabled
                if (isset($option['product_page']) && $option['product_page'] == 0) continue;

                $product_option_value_data = array();
                foreach ($option['product_option_value'] as $option_value) {
                    if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
                        if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
                            $price = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax') ? 'P' : false));
                        } else {
                            $price = false;
                        }

                        $product_option_value_data[] = array(
                            'price_value' => $option_value['price'],
                            'points_value' => intval($option_value['points_prefix'] . $option_value['points']),
                            'product_option_value_id' => $option_value['product_option_value_id'],
                            'option_value_id' => $option_value['option_value_id'],
                            'name' => $option_value['name'],
                            'image' => $this->model_tool_image->resize($option_value['image'], 50, 50),
                            'product_option_image' => $this->model_tool_image->resize($option_value['product_option_image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height')),
                            'product_option_image_popup' => $this->model_tool_image->resize($option_value['product_option_image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height')),
                            'price' => $price,
                            'price_prefix' => $option_value['price_prefix']
                        );
                    }
                }

                $data['options'][] = array(
                    'product_option_id' => $option['product_option_id'],
                    'product_option_value' => $product_option_value_data,
                    'option_id' => $option['option_id'],
                    'name' => $option['name'],
                    'product_page' => isset($option['product_page']) ? ((int)$option['product_page']) : 1,
                    'type' => $option['type'],
                    'style' => $option['style'],
                    'value' => $option['value'],
                    'required' => $option['required']
                );
            }

            if ($product_info['minimum']) {
                $data['minimum'] = $product_info['minimum'];
            } else {
                $data['minimum'] = 1;
            }

            /*code start*/
            $promo_top_right = $this->model_catalog_product->getPromo($product_info['product_id'], $product_info['promo_top_right']);

            if (!empty($promo_top_right['promo_text']) && $promo_on) {
                if (!empty($promo_top_right['promo_link'])) {
                    $promo_tags = '<span>Notes: </span><span style="color:red"><a href="' . $promo_top_right['promo_link'] . '" Title="Click Me">' . $promo_top_right['promo_text'] . '</a></span>';
                    if (!empty($promo_top_right['pimage'])) {
                        $promo_tags = $promo_tags . '<br /><tr><td colspan="2"><a href="' . $promo_top_right['promo_link'] . '" Title="Click Me"><img src="image/' . $promo_top_right['pimage'] . '" /></a></td></tr>';
                    }
                } else {
                    $promo_tags = '<span>Notes: </span><span style="color: red; font-weight:bold;">' . $promo_top_right['promo_text'] . '</span>';
                    if (!empty($promo_top_right['pimage'])) {
                        $promo_tags = $promo_tags . '<br /><tr><td colspan="2"><img src="image/' . $promo_top_right['pimage'] . '" /></td></tr>';
                    }
                }
            } else {
                $promo_tags = '';
            }

            if (!empty($promo_top_right['promo_text']) && $promo_on) {
                $promo_tag_product_top_right = '<div class="promotags" style="width:100px;height:100px;top:0px;right:0px;background: url(\'' . 'image/' . $promo_top_right['image'] . '\') no-repeat;background-position:top right"></div>';
            } else {
                $promo_tag_product_top_right = '';
            }

            $promo_top_left = $this->model_catalog_product->getPromo($product_info['product_id'], $product_info['promo_top_left']);
            if (!empty($promo_top_left['promo_text']) && $promo_on) {
                $promo_tag_product_top_left = '<div class="promotags" style="width:100px;height:100px;top:0px;left:0px;background: url(\'' . 'image/' . $promo_top_left['image'] . '\') no-repeat;background-position:top left"></div>';
            } else {
                $promo_tag_product_top_left = '';
            }

            $promo_bottom_left = $this->model_catalog_product->getPromo($product_info['product_id'], $product_info['promo_bottom_left']);
            if (!empty($promo_bottom_left['promo_text']) && $promo_on) {
                $promo_tag_product_bottom_left = '<div class="promotags" style="width:100px;height:100px;bottom:0px;left:0px;background: url(\'' . 'image/' . $promo_bottom_left['image'] . '\') no-repeat;background-position:bottom left"></div>';
            } else {
                $promo_tag_product_bottom_left = '';
            }

            $promo_bottom_right = $this->model_catalog_product->getPromo($product_info['product_id'], $product_info['promo_bottom_right']);
            if (!empty($promo_bottom_right['promo_text']) && $promo_on) {
                $promo_tag_product_bottom_right = '<div class="promotags" style="width:100px;height:100px;bottom:0px;right:0px;background: url(\'' . 'image/' . $promo_bottom_right['image'] . '\') no-repeat;background-position:bottom right"></div>';
            } else {
                $promo_tag_product_bottom_right = '';
            }
            /*code end*/

            $data['review_status'] = $this->config->get('config_review_status');

            if ($this->config->get('config_review_guest') || $this->customer->isLogged()) {
                $data['review_guest'] = true;
            } else {
                $data['review_guest'] = false;
            }

            if ($this->customer->isLogged()) {
                $data['customer_name'] = $this->customer->getFirstName() . '&nbsp;' . $this->customer->getLastName();
            } else {
                $data['customer_name'] = '';
            }

            // Start custom_fields
            $custom_language_id = false;

            $this->load->model('localisation/language');

            $languages = $this->model_localisation_language->getLanguages();
            foreach ($languages as $key => $value) {
                if ($key == $this->language->get('code')) {
                    $custom_language_id = $value['language_id'];
                }
            }

            $data['custom_field'] = array();
            if (!empty($product_info['custom_field'])) {
                $custom_fields = json_decode($product_info['custom_field'], true);
                if (!empty($custom_fields[$custom_language_id])) {
                    foreach ($custom_fields[$custom_language_id] as $custom_fields) {
                        $data['custom_field'][$custom_fields['name']] = $custom_fields['value'];
                    }
                }
            }
            // var_dump($data['custom_field']);
            // End custom_fields

            $data['reviews'] = sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']);
            $data['rating'] = (int)$product_info['rating'];
            $data['description'] = html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8');
            $data['attribute_groups'] = $this->model_catalog_product->getProductAttributes($this->request->get['product_id']);

            /*code start*/
            $data['promo_tags'] = $promo_tags;
            $data['promo_tag_product_top_right'] = $promo_tag_product_top_right;
            $data['promo_tag_product_top_left'] = $promo_tag_product_top_left;
            $data['promo_tag_product_bottom_left'] = $promo_tag_product_bottom_left;
            $data['promo_tag_product_bottom_right'] = $promo_tag_product_bottom_right;
            /*code end*/

            $data['products'] = array();

            $results = $this->model_catalog_product->getProductRelated($this->request->get['product_id']);

            foreach ($results as $result) {
                if ($result['image']) {
                    $image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_related_width'), $this->config->get('config_image_related_height'));
                } else {
                    $image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_related_width'), $this->config->get('config_image_related_height'));
                }

                if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                    $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
                } else {
                    $price = false;
                }

                if ((float)$result['special']) {
                    $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
                } else {
                    $special = false;
                }

                if ($this->config->get('config_tax')) {
                    $tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
                } else {
                    $tax = false;
                }

                if ($this->config->get('config_review_status')) {
                    $rating = (int)$result['rating'];
                } else {
                    $rating = false;
                }

                $data['products'][] = array(
                    'product_id' => $result['product_id'],
                    'thumb' => $image,
                    'name' => $result['name'],
                    'quantity' => $result['quantity'],
                    'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
                    'price' => $price,
                    'special' => $special,
                    'tax' => $tax,
                    'minimum' => $result['minimum'] > 0 ? $result['minimum'] : 1,
                    'rating' => $rating,
                    'href' => $this->url->link('product/product', 'product_id=' . $result['product_id'])
                );
            }

            $data['tags'] = array();

            if ($product_info['tag']) {
                $tags = explode(',', $product_info['tag']);

                foreach ($tags as $tag) {
                    $data['tags'][] = array(
                        'tag' => trim($tag),
                        'href' => $this->url->link('product/search', 'tag=' . trim($tag))
                    );
                }
            }

            $data['text_payment_recurring'] = $this->language->get('text_payment_recurring');
            $data['recurrings'] = $this->model_catalog_product->getProfiles($this->request->get['product_id']);

            $this->model_catalog_product->updateViewed($this->request->get['product_id']);

            if ($this->config->get('config_google_captcha_status')) {
                $this->document->addScript('https://www.google.com/recaptcha/api.js');

                $data['site_key'] = $this->config->get('config_google_captcha_public');
            } else {
                $data['site_key'] = '';
            }

            /* layout patch - choose template by path */
            $this->load->model('design/layout');
            if (isset ($this->request->get ['route'])) {
                $route = ( string )$this->request->get ['route'];
            } else {
                $route = 'common/home';
            }
            $layout_template = $this->model_design_layout->getLayoutTemplate($route);
            $isLayoutRoute = true;
            if (!$layout_template) {
                $layout_template = 'product';
                $isLayoutRoute = false;
            }
            // get general layout template
            if (!$isLayoutRoute) {
                $layout_id = $this->model_catalog_product->getProductLayoutId($this->request->get['product_id']);
                if ($layout_id) {
                    $tmp_layout_template = $this->model_design_layout->getGeneralLayoutTemplate($layout_id);
                    if ($tmp_layout_template)
                        $layout_template = $tmp_layout_template;
                }
            }

            $data['column_left'] = $this->load->controller('common/column_left');
            $data['column_right'] = $this->load->controller('common/column_right');
            $data['content_top'] = $this->load->controller('common/content_top');
            $data['content_bottom'] = $this->load->controller('common/content_bottom');
            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');
            $data['product_series'] = $this->load->controller('product/series');

            // Группа пользователя
            $customer_group_now = $this->config->get('config_customer_group_id'); //$this->customer->getGroupId()

            // Группа пользоватедля для доступа к категории
            $category_info = $this->model_catalog_product->getCategories($product_id);
            if (!empty($category_info)) {
                $category_id_product = $category_info[0]['category_id'];
                $category_info = $this->model_catalog_product->getCategory($category_id_product);
                $customer_group_access = $category_info['customer_group_id'];

                if ($customer_group_now == $customer_group_access || $customer_group_access == '1') {
                    $data['group_access'] = true;
                } else {
                    $data['group_access'] = false;
                }
            } else {
                $data['group_access'] = true;
            }

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/' . $layout_template . '.tpl')) {
                $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/product/' . $layout_template . '.tpl', $data));
            } else {
                $this->response->setOutput($this->load->view('default/template/product/' . $layout_template . '.tpl', $data));
            }
        } else {
            $url = '';

            if (isset($this->request->get['path'])) {
                $url .= '&path=' . $this->request->get['path'];
            }

            if (isset($this->request->get['filter'])) {
                $url .= '&filter=' . $this->request->get['filter'];
            }

            if (isset($this->request->get['manufacturer_id'])) {
                $url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
            }

            if (isset($this->request->get['search'])) {
                $url .= '&search=' . $this->request->get['search'];
            }

            if (isset($this->request->get['tag'])) {
                $url .= '&tag=' . $this->request->get['tag'];
            }

            if (isset($this->request->get['description'])) {
                $url .= '&description=' . $this->request->get['description'];
            }

            if (isset($this->request->get['category_id'])) {
                $url .= '&category_id=' . $this->request->get['category_id'];
            }

            if (isset($this->request->get['sub_category'])) {
                $url .= '&sub_category=' . $this->request->get['sub_category'];
            }

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            if (isset($this->request->get['limit'])) {
                $url .= '&limit=' . $this->request->get['limit'];
            }

            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_error'),
                'href' => $this->url->link('product/product', $url . '&product_id=' . $product_id)
            );

            $this->document->setTitle($this->language->get('text_error'));

            $data['heading_title'] = $this->language->get('text_error');

            $data['text_error'] = $this->language->get('text_error');

            $data['button_continue'] = $this->language->get('button_continue');

            $data['continue'] = $this->url->link('common/home');

            $this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

            $data['column_left'] = $this->load->controller('common/column_left');
            $data['column_right'] = $this->load->controller('common/column_right');
            $data['content_top'] = $this->load->controller('common/content_top');
            $data['content_bottom'] = $this->load->controller('common/content_bottom');
            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
                $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/error/not_found.tpl', $data));
            } else {
                $this->response->setOutput($this->load->view('default/template/error/not_found.tpl', $data));
            }
        }
    }

    public function review()
    {
        $this->load->language('product/product');

        $this->load->model('catalog/review');

        $data['text_no_reviews'] = $this->language->get('text_no_reviews');

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }

        $data['reviews'] = array();

        $review_total = $this->model_catalog_review->getTotalReviewsByProductId($this->request->get['product_id']);

        $results = $this->model_catalog_review->getReviewsByProductId($this->request->get['product_id'], ($page - 1) * 5, 5);

        foreach ($results as $result) {
            $data['reviews'][] = array(
                'author' => $result['author'],
                'text' => nl2br($result['text']),
                'rating' => (int)$result['rating'],
                'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added']))
            );
        }

        $pagination = new Pagination();
        $pagination->total = $review_total;
        $pagination->page = $page;
        $pagination->limit = 5;
        $pagination->url = $this->url->link('product/product/review', 'product_id=' . $this->request->get['product_id'] . '&page={page}');

        $data['pagination'] = $pagination->render();

        $data['results'] = sprintf($this->language->get('text_pagination'), ($review_total) ? (($page - 1) * 5) + 1 : 0, ((($page - 1) * 5) > ($review_total - 5)) ? $review_total : ((($page - 1) * 5) + 5), $review_total, ceil($review_total / 5));

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/review.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/product/review.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/template/product/review.tpl', $data));
        }
    }

    public function write()
    {
        $this->load->language('product/product');

        $json = array();

        if ($this->request->server['REQUEST_METHOD'] == 'POST') {
            if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 25)) {
                $json['error'] = $this->language->get('error_name');
            }

            if ((utf8_strlen($this->request->post['text']) < 25) || (utf8_strlen($this->request->post['text']) > 1000)) {
                $json['error'] = $this->language->get('error_text');
            }

            if (empty($this->request->post['rating']) || $this->request->post['rating'] < 0 || $this->request->post['rating'] > 5) {
                $json['error'] = $this->language->get('error_rating');
            }

            if ($this->config->get('config_google_captcha_status') && empty($json['error'])) {
                if (isset($this->request->post['g-recaptcha-response'])) {
                    $recaptcha = file_get_contents('https://www.google.com/recaptcha/api/siteverify?secret=' . urlencode($this->config->get('config_google_captcha_secret')) . '&response=' . $this->request->post['g-recaptcha-response'] . '&remoteip=' . $this->request->server['REMOTE_ADDR']);

                    $recaptcha = json_decode($recaptcha, true);

                    if (!$recaptcha['success']) {
                        $json['error'] = $this->language->get('error_captcha');
                    }
                } else {
                    $json['error'] = $this->language->get('error_captcha');
                }
            }

            if (!isset($json['error'])) {
                $this->load->model('catalog/review');

                $this->model_catalog_review->addReview($this->request->get['product_id'], $this->request->post);

                $json['success'] = $this->language->get('text_success');
            }
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function getRecurringDescription()
    {
        $this->language->load('product/product');
        $this->load->model('catalog/product');

        if (isset($this->request->post['product_id'])) {
            $product_id = $this->request->post['product_id'];
        } else {
            $product_id = 0;
        }

        if (isset($this->request->post['recurring_id'])) {
            $recurring_id = $this->request->post['recurring_id'];
        } else {
            $recurring_id = 0;
        }

        if (isset($this->request->post['quantity'])) {
            $quantity = $this->request->post['quantity'];
        } else {
            $quantity = 1;
        }

        $product_info = $this->model_catalog_product->getProduct($product_id);
        $recurring_info = $this->model_catalog_product->getProfile($product_id, $recurring_id);

        $json = array();

        if ($product_info && $recurring_info) {
            if (!$json) {
                $frequencies = array(
                    'day' => $this->language->get('text_day'),
                    'week' => $this->language->get('text_week'),
                    'semi_month' => $this->language->get('text_semi_month'),
                    'month' => $this->language->get('text_month'),
                    'year' => $this->language->get('text_year'),
                );

                if ($recurring_info['trial_status'] == 1) {
                    $price = $this->currency->format($this->tax->calculate($recurring_info['trial_price'] * $quantity, $product_info['tax_class_id'], $this->config->get('config_tax')));
                    $trial_text = sprintf($this->language->get('text_trial_description'), $price, $recurring_info['trial_cycle'], $frequencies[$recurring_info['trial_frequency']], $recurring_info['trial_duration']) . ' ';
                } else {
                    $trial_text = '';
                }

                $price = $this->currency->format($this->tax->calculate($recurring_info['price'] * $quantity, $product_info['tax_class_id'], $this->config->get('config_tax')));

                if ($recurring_info['duration']) {
                    $text = $trial_text . sprintf($this->language->get('text_payment_description'), $price, $recurring_info['cycle'], $frequencies[$recurring_info['frequency']], $recurring_info['duration']);
                } else {
                    $text = $trial_text . sprintf($this->language->get('text_payment_cancel'), $price, $recurring_info['cycle'], $frequencies[$recurring_info['frequency']], $recurring_info['duration']);
                }

                $json['success'] = $text;
            }
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
}
