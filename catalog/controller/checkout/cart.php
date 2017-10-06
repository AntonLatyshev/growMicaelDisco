<?php
class ControllerCheckoutCart extends Controller
{

    public function index()
    {

//        $this->response->redirect($this->url->link('checkout/checkout'));

        $this->load->model('tool/image');

        $this->load->language('checkout/cart');

        $data['column_model'] = $this->language->get('column_model');
        $data['column_edit'] = $this->language->get('column_edit');
        $data['column_quantity'] = $this->language->get('column_quantity');
        $data['column_promo_handler'] = $this->language->get('column_promo_handler');
        $data['column_promo_placeholder'] = $this->language->get('column_promo_placeholder');
        $data['column_promo_info'] = $this->config->get('config_cart_description_promo');

        if ($this->cart->hasProducts() || !empty($this->session->data['vouchers'])) {

            if (!$this->cart->hasStock() && (!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning'))) {
                $data['error_warning'] = $this->language->get('error_stock');
            } elseif (isset($this->session->data['error'])) {
                $data['error_warning'] = $this->session->data['error'];

                unset($this->session->data['error']);
            } else {
                $data['error_warning'] = '';
            }

            if ($this->config->get('config_customer_price') && !$this->customer->isLogged()) {
                $data['attention'] = sprintf($this->language->get('text_login'), $this->url->link('account/login'), $this->url->link('account/register'));
            } else {
                $data['attention'] = '';
            }

            if (isset($this->session->data['success'])) {
                $data['success'] = $this->session->data['success'];

                unset($this->session->data['success']);
            } else {
                $data['success'] = '';
            }

//            $this->load->model('checkout/order');
//
//            $this->session->data['order_id'] = $this->model_checkout_order->addOrder($order_data);

            $this->load->model('tool/image');
            $this->load->model('tool/upload');

            $data['products'] = array();

            $products = $this->cart->getProducts();

            foreach ($products as $product) {
                $option_data = array();

                foreach ($product['option'] as $option) {
                    if ($option['type'] != 'file') {
                        $value = $option['value'];
                    } else {
                        $upload_info = $this->model_tool_upload->getUploadByCode($option['value']);

                        if ($upload_info) {
                            $value = $upload_info['name'];
                        } else {
                            $value = '';
                        }
                    }

                    $option_data[] = array(
                        'name'  => $option['name'],
                        'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value)
                    );
                }

                $recurring = '';

                if ($product['recurring']) {
                    $frequencies = array(
                        'day'        => $this->language->get('text_day'),
                        'week'       => $this->language->get('text_week'),
                        'semi_month' => $this->language->get('text_semi_month'),
                        'month'      => $this->language->get('text_month'),
                        'year'       => $this->language->get('text_year'),
                    );

                    if ($product['recurring']['trial']) {
                        $recurring = sprintf($this->language->get('text_trial_description'), $this->currency->format($this->tax->calculate($product['recurring']['trial_price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax'))), $product['recurring']['trial_cycle'], $frequencies[$product['recurring']['trial_frequency']], $product['recurring']['trial_duration']) . ' ';
                    }

                    if ($product['recurring']['duration']) {
                        $recurring .= sprintf($this->language->get('text_payment_description'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax'))), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
                    } else {
                        $recurring .= sprintf($this->language->get('text_payment_cancel'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax'))), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
                    }
                }

                $data['products'][] = array(
                    'key'        => $product['key'],
                    'product_id' => $product['product_id'],
                    'thumb'      => $product['image'] && file_exists(DIR_IMAGE . $product['image']) ? $this->model_tool_image->resize($product['image'], 76, 76) : $this->model_tool_image->resize('no_image.jpg', 76, 76),
                    'name'       => $product['name'],
                    'model'      => $product['model'],
                    'option'     => $option_data,
                    'recurring'  => $recurring,
                    'quantity'   => $product['quantity'],
                    'subtract'   => $product['subtract'],
                    'price'      => $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax'))),
                    'total'      => $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')) * $product['quantity']),
                    'href'       => $this->url->link('product/product', 'product_id=' . $product['product_id']),
                );
            }

        }

        // Totals
        $this->load->model('extension/extension');

        $total_data = array();
        $total = 0;
        $taxes = $this->cart->getTaxes();

        // Display prices
        if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
            $sort_order = array();

            $results = $this->model_extension_extension->getExtensions('total');

            foreach ($results as $key => $value) {
                $sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
            }

            array_multisort($sort_order, SORT_ASC, $results);

            foreach ($results as $result) {
                if ($this->config->get($result['code'] . '_status')) {
                    $this->load->model('total/' . $result['code']);

                    $this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
                }
            }

            $sort_order = array();

            foreach ($total_data as $key => $value) {
                $sort_order[$key] = $value['sort_order'];
            }

            array_multisort($sort_order, SORT_ASC, $total_data);
        }

        $data['totals'] = array();
        $data['totals_total'] = array();

        foreach ($total_data as $total) {
            if ($total['code'] == 'total') {
                $data['totals_total']['title'] = $total['title'];
                $data['totals_total']['text'] = $this->currency->format($total['value']);
            } else {
                $data['totals'][] = array(
                    'title' => $total['title'],
                    'text' => $this->currency->format($total['value'])
                );
            }
        }

        if ( !empty($this->session->data['payment_method']['code']) ) {
            $data['payment'] = $this->load->controller('payment/' . $this->session->data['payment_method']['code']);
        } else {
            $data['payment'] = '';
        }

        if (isset($this->session->data['coupon'])) {
            $data['coupon'] = $this->session->data['coupon'];
        } else {
            $data['coupon'] = '';
        }

        if (isset($this->session->data['voucher'])) {
            $data['voucher'] = $this->session->data['voucher'];
        } else {
            $data['voucher'] = '';
        }

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/cart.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/checkout/cart.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/template/checkout/cart.tpl', $data));
        }

    }

    public function add() {
        $this->load->language('checkout/cart');

        $data['text_edit'] = $this->language->get('text_edit');
        $data['text_model'] = $this->language->get('text_model');
        $data['text_price'] = $this->language->get('text_price');
        $data['text_quantity'] = $this->language->get('text_quantity');
        $data['text_total'] = $this->language->get('text_total');

        $json = array();

        if (isset($this->request->post['product_id'])) {
            $product_id = (int)$this->request->post['product_id'];
        } else {
            $product_id = 0;
        }

        $this->load->model('catalog/product');

        $product_info = $this->model_catalog_product->getProduct($product_id);

        if ($product_info) {
            if (isset($this->request->post['quantity']) && ((int)$this->request->post['quantity'] >= $product_info['minimum'])) {
                $quantity = (int)$this->request->post['quantity'];
            } else {
                $quantity = $product_info['minimum'] ? $product_info['minimum'] : 1;
            }

            if (isset($this->request->post['option'])) {
                $option = array_filter($this->request->post['option']);
            } else {
                $option = array();
            }

            $product_options = $this->model_catalog_product->getProductOptions($this->request->post['product_id']);

            foreach ($product_options as $product_option) {
                if ($product_option['required'] && empty($option[$product_option['product_option_id']])) {
                    $json['error']['option'][$product_option['product_option_id']] = sprintf($this->language->get('error_required'), $product_option['name']);
                }
            }

            if (isset($this->request->post['recurring_id'])) {
                $recurring_id = $this->request->post['recurring_id'];
            } else {
                $recurring_id = 0;
            }

            $recurrings = $this->model_catalog_product->getProfiles($product_info['product_id']);

            if ($recurrings) {
                $recurring_ids = array();

                foreach ($recurrings as $recurring) {
                    $recurring_ids[] = $recurring['recurring_id'];
                }

                if (!in_array($recurring_id, $recurring_ids)) {
                    $json['error']['recurring'] = $this->language->get('error_recurring_required');
                }
            }

            if (!$json) {
                $this->cart->add($this->request->post['product_id'], $quantity, $option, $recurring_id);
                $this->load->model('tool/image');

                $this->template = $this->config->get('config_template') . '/template/common/cart.tpl';

                $product['product_id'] = (int)$product_id;

                if ($option) {
                    $product['option'] = $option;
                }

                if ($recurring_id) {
                    $product['recurring_id'] = (int)$recurring_id;
                }

                $key = base64_encode(serialize($product));

                $data['cart_products'] = $this->cart->getProducts();

                if ((strtotime(date('Y-m-d')) >= strtotime($product_info['promo_date_start'])) && (strtotime(date('Y-m-d')) <= strtotime($product_info['promo_date_end'])) || (($product_info['promo_date_start'] == '0000-00-00') && ($product_info['promo_date_end'] == '0000-00-00'))) {
                    $promo_on = TRUE;
                } else {
                    $promo_on = FALSE;
                }

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

                $data['cart_products'][$key]['key'] = $key;
                $data['cart_products'][$key]['image'] = $data['cart_products'][$key]['image'] && file_exists(DIR_IMAGE . $data['cart_products'][$key]['image']) ? $this->model_tool_image->resize($data['cart_products'][$key]['image'], 170, 269) : $this->model_tool_image->resize('no_image.jpg', 170, 269);
                $data['cart_products'][$key]['href'] = $this->url->link('product/product', 'product_id=' . $product_id);
                $data['cart_products'][$key]['price'] = $this->currency->format($this->tax->calculate($data['cart_products'][$key]['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
                $data['cart_products'][$key]['total'] = $this->currency->format($this->tax->calculate($data['cart_products'][$key]['total'], $product_info['tax_class_id'], $this->config->get('config_tax')));

                $data['cart_products'][$key]['promo_tags'] = $promo_tags;
                $data['cart_products'][$key]['promo_tag_product_top_right'] = $promo_tag_product_top_right;
                $data['cart_products'][$key]['promo_tag_product_top_left'] = $promo_tag_product_top_left;
                $data['cart_products'][$key]['promo_tag_product_bottom_left'] = $promo_tag_product_bottom_left;
                $data['cart_products'][$key]['promo_tag_product_bottom_right'] = $promo_tag_product_bottom_right;

                $data['product'] = $data['cart_products'][$key];

                $data['class_page'] = 'cart-order';
                $data['continue'] = $this->url->link('common/home');
                $data['checkout'] = $this->url->link('checkout/checkout');
                $data['button_continue'] = $this->language->get('button_continue');
                $data['button_checkout'] = $this->language->get('button_checkout');

                if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/cart_popup.tpl')) {
                    $json['success'] = $this->load->view($this->config->get('config_template') . '/template/common/cart_popup.tpl', $data);
                } else {
                    $json['success'] = $this->load->view('default/template/checkout/cart_popup.tpl', $data);
                }

                unset($this->session->data['shipping_method']);
                unset($this->session->data['shipping_methods']);
                unset($this->session->data['payment_method']);
                unset($this->session->data['payment_methods']);

                $total = $this->getTotal();

                $json['total'] = sprintf($this->language->get('text_items'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total));
            } else {
                $json['redirect'] = str_replace('&amp;', '&', $this->url->link('product/product', 'product_id=' . $this->request->post['product_id']));
            }
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function refresh() {
        $this->load->language('checkout/cart');

        $json = array();

        $key = $this->request->post['key'];
        $quantity = $this->request->post['quantity'];

        // Update
        if (!empty($quantity)) {
            $this->cart->update($key, $quantity);

            unset($this->session->data['shipping_method']);
            unset($this->session->data['shipping_methods']);
            unset($this->session->data['payment_method']);
            unset($this->session->data['payment_methods']);
            unset($this->session->data['reward']);

            $products = $this->cart->getProducts();

            $json['product_total'] = $this->currency->format($this->tax->calculate($products[$key]['total'], $products[$key]['tax_class_id'], $this->config->get('config_tax')));

            $total = $this->getTotal();
            $json['total'] = sprintf($this->language->get('text_items'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total));
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function edit() {
        $this->load->language('checkout/cart');

        $json = array();

        // Update
        if (!empty($this->request->post['quantity'])) {
            foreach ($this->request->post['quantity'] as $key => $value) {
                $this->cart->update($key, $value);
            }

            unset($this->session->data['shipping_method']);
            unset($this->session->data['shipping_methods']);
            unset($this->session->data['payment_method']);
            unset($this->session->data['payment_methods']);
            unset($this->session->data['reward']);

            $this->response->redirect($this->url->link('checkout/checkout'));
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
    
    public function edit_cart() {
        $this->load->language('checkout/cart_popup');

        $data['text_edit'] = $this->language->get('text_edit');
        $data['text_model'] = $this->language->get('text_model');
        $data['text_price'] = $this->language->get('text_price');
        $data['text_quantity'] = $this->language->get('text_quantity');
        $data['text_total'] = $this->language->get('text_total');
        $data['button_back'] = $this->language->get('button_back');
        $data['button_save'] = $this->language->get('button_save');

        $json = array();

        if (isset($this->request->post['product_id'])) {
            $product_id = (int)$this->request->post['product_id'];
        } else {
            $product_id = 0;
        }

        $this->load->model('tool/image');
        $this->load->model('tool/upload');

        $data['product'] = array();

        $products = $this->cart->getProducts();

        foreach ($products as $product) {
            if ($product['product_id'] == $product_id) {

                $option_data = array();

                foreach ($product['option'] as $option) {
                    if ($option['type'] != 'file') {
                        $value = $option['value'];
                    } else {
                        $upload_info = $this->model_tool_upload->getUploadByCode($option['value']);

                        if ($upload_info) {
                            $value = $upload_info['name'];
                        } else {
                            $value = '';
                        }
                    }

                    $option_data[] = array(
                        'name'  => $option['name'],
                        'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value)
                    );
                }

                $recurring = '';

                if ($product['recurring']) {
                    $frequencies = array(
                        'day'        => $this->language->get('text_day'),
                        'week'       => $this->language->get('text_week'),
                        'semi_month' => $this->language->get('text_semi_month'),
                        'month'      => $this->language->get('text_month'),
                        'year'       => $this->language->get('text_year'),
                    );

                    if ($product['recurring']['trial']) {
                        $recurring = sprintf($this->language->get('text_trial_description'), $this->currency->format($this->tax->calculate($product['recurring']['trial_price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax'))), $product['recurring']['trial_cycle'], $frequencies[$product['recurring']['trial_frequency']], $product['recurring']['trial_duration']) . ' ';
                    }

                    if ($product['recurring']['duration']) {
                        $recurring .= sprintf($this->language->get('text_payment_description'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax'))), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
                    } else {
                        $recurring .= sprintf($this->language->get('text_payment_cancel'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax'))), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
                    }
                }

                $price = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')));
                $price_d = $this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax'));
                $price_s = ' грн';

                $total = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')) * $product['quantity']);
                $total_d = $this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')) * $product['quantity'];
                $total_s = ' грн';

                $data['product'] = array(
                    'key'        => $product['key'],
                    'product_id' => $product['product_id'],
                    'thumb'      => $product['image'] && file_exists(DIR_IMAGE . $product['image']) ? $this->model_tool_image->resize($product['image'], 200, 200) : $this->model_tool_image->resize('no_image.jpg', 76, 76),
                    'name'       => $product['name'],
                    'model'      => $product['model'],
                    'option'     => $option_data,
                    'recurring'  => $recurring,
                    'quantity'   => $product['quantity'],
                    'subtract'   => $product['subtract'],
                    'price'      => $price,
                    'price_d'    => $price_d,
                    'price_s'    => $price_s,
                    'total'      => $total,
                    'total_d'    => $total_d,
                    'total_s'    => $total_s,
                    'href'       => $this->url->link('product/product', 'product_id=' . $product['product_id']),
                );
            }
        }

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/cart_popup.tpl')) {
            $json['success'] = $this->load->view($this->config->get('config_template') . '/template/checkout/cart_popup.tpl', $data);
        } else {
            $json['success'] = $this->load->view('default/template/checkout/cart_popup.tpl', $data);
        }

        
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function refresh_popup_data() {
        $this->load->language('checkout/cart');

        $json = array();

        $key = $this->request->post['key'];
        $quantity = $this->request->post['quantity'];

        // Update
        if (!empty($quantity)) {
            $this->cart->update($key, $quantity);

//            unset($this->session->data['shipping_method']);
//            unset($this->session->data['shipping_methods']);
//            unset($this->session->data['payment_method']);
//            unset($this->session->data['payment_methods']);
//            unset($this->session->data['reward']);

            $products = $this->cart->getProducts();

            $json['quantity'] = $products[$key]['quantity'];
            
            $json['product_id'] = $products[$key]['product_id'];

            $json['product_total'] = $this->currency->format($this->tax->calculate($products[$key]['total'], $products[$key]['tax_class_id'], $this->config->get('config_tax')));

            $total = $this->getTotal();

            $json['total'] = $this->currency->format($total);


            // Totals
            $this->load->model('extension/extension');

            $total_data = array();
            $total = 0;
            $taxes = $this->cart->getTaxes();

            if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                $sort_order = array();

                $results = $this->model_extension_extension->getExtensions('total');

                foreach ($results as $key => $value) {
                    $sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
                }

                array_multisort($sort_order, SORT_ASC, $results);

                foreach ($results as $result) {
                    if ($this->config->get($result['code'] . '_status')) {
                        $this->load->model('total/' . $result['code']);

                        $this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
                    }
                }

                $sort_order = array();

                foreach ($total_data as $key => $value) {
                    $sort_order[$key] = $value['sort_order'];
                }

                array_multisort($sort_order, SORT_ASC, $total_data);
            }

            $data_totals = array();
            $data_totals_total = array();

            foreach ($total_data as $total) {
                if ($total['code'] == 'total') {
                    $data_totals_total['title'] = $total['title'];
                    $data_totals_total['text'] = $this->currency->format($total['value']);
                } else {
                    $data_totals[] = array(
                        'title' => $total['title'],
                        'text' => $this->currency->format($total['value'])
                    );
                }
            }

            $json['totals'] = '';

            foreach ($data_totals as $totals) {
                $json['totals'] .= '<div class="cart-total">' . $totals['title'] . ': <span class="price">' . $totals['text'] . '</span></div>';
            }
            
            $json['totals_total'] = $data_totals_total['title'] . ': <span class="price">' . $data_totals_total['text'] . '</span>';

        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
    
    // получение итоговых сумм
    public function refresh_totals() {
        $json = array();

        // Totals
        $this->load->model('extension/extension');

        $total_data = array();
        $total = 0;
        $taxes = $this->cart->getTaxes();

        if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
            $sort_order = array();

            $results = $this->model_extension_extension->getExtensions('total');

            foreach ($results as $key => $value) {
                $sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
            }

            array_multisort($sort_order, SORT_ASC, $results);

            foreach ($results as $result) {
                if ($this->config->get($result['code'] . '_status')) {
                    $this->load->model('total/' . $result['code']);

                    $this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
                }
            }

            $sort_order = array();

            foreach ($total_data as $key => $value) {
                $sort_order[$key] = $value['sort_order'];
            }

            array_multisort($sort_order, SORT_ASC, $total_data);
        }

        $data_totals = array();
        $data_totals_total = array();

        foreach ($total_data as $total) {
            if ($total['code'] == 'total') {
                $data_totals_total['title'] = $total['title'];
                $data_totals_total['text'] = $this->currency->format($total['value']);
            } else {
                $data_totals[] = array(
                    'title' => $total['title'],
                    'text' => $this->currency->format($total['value'])
                );
            }
        }

        $json['totals'] = '';

        foreach ($data_totals as $totals) {
            $json['totals'] .= '<div class="cart-total">' . $totals['title'] . ': <span class="price">' . $totals['text'] . '</span></div>';
        }

        $json['totals_total'] = $data_totals_total['title'] . ': <span class="price">' . $data_totals_total['text'] . '</span>';

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function remove() {
        $this->load->language('checkout/cart');

        $json = array();

        // Remove
        if (isset($this->request->post['key'])) {

            $product = unserialize(base64_decode($this->request->post['key']));

            $json['product_id'] = $product['product_id'];

            $this->cart->remove($this->request->post['key']);

            unset($this->session->data['vouchers'][$this->request->post['key']]);

            $this->session->data['success'] = $this->language->get('text_remove');

            unset($this->session->data['shipping_method']);
            unset($this->session->data['shipping_methods']);
            unset($this->session->data['payment_method']);
            unset($this->session->data['payment_methods']);
            unset($this->session->data['reward']);

            // Totals
            $this->load->model('extension/extension');

            $total_data = array();
            $total = 0;
            $taxes = $this->cart->getTaxes();

            // Display prices
            if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                $sort_order = array();

                $results = $this->model_extension_extension->getExtensions('total');

                foreach ($results as $key => $value) {
                    $sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
                }

                array_multisort($sort_order, SORT_ASC, $results);

                foreach ($results as $result) {
                    if ($this->config->get($result['code'] . '_status')) {
                        $this->load->model('total/' . $result['code']);

                        $this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
                    }
                }

                $sort_order = array();

                foreach ($total_data as $key => $value) {
                    $sort_order[$key] = $value['sort_order'];
                }

                array_multisort($sort_order, SORT_ASC, $total_data);
            }

            $json['total'] = sprintf($this->language->get('text_items'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total));
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    private function getTotal() {
        $this->load->model('extension/extension');

        $total_data = array();
        $total = 0;
        $taxes = $this->cart->getTaxes();

        // Display prices
        if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
            $sort_order = array();

            $results = $this->model_extension_extension->getExtensions('total');

            foreach ($results as $key => $value) {
                $sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
            }

            array_multisort($sort_order, SORT_ASC, $results);

            foreach ($results as $result) {
                if ($this->config->get($result['code'] . '_status')) {
                    $this->load->model('total/' . $result['code']);

                    $this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
                }
            }

            $sort_order = array();

            foreach ($total_data as $key => $value) {
                $sort_order[$key] = $value['sort_order'];
            }

            array_multisort($sort_order, SORT_ASC, $total_data);
        }

        return $total;
    }

}