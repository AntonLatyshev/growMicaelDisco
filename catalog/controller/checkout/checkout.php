<?php

class ControllerCheckoutCheckout extends Controller
{

    public function index()
    {

        $this->updateSession();

//        echo '<pre>';
//        print_r($this->session);
//        echo '</pre>';

        unset($this->session->data['guest']['step_second']);

        if ((!$this->cart->hasProducts() && empty($this->session->data['vouchers'])) || (!$this->cart->hasStock() && !$this->config->get('config_stock_checkout'))) {
            $this->response->redirect($this->url->link('error/check_not_found'));
        }

        if ( empty($this->session->data['order_id']) ) {
            $this->addOrder();
        }

        $this->load->language('checkout/checkout');

        $data['cart'] = $this->load->controller('checkout/cart');
        $data['step_first'] = $this->load->controller('checkout/step_first');
        $data['step_second'] = $this->load->controller('checkout/step_second');

        $data['text_none'] = $this->language->get('text_none');
        $data['text_select'] = $this->language->get('text_select');

        $data['header'] = $this->load->controller('checkout/header');
        $data['footer'] = $this->load->controller('checkout/footer');

        $data['address_1'] = ( !empty($this->session->data['shipping_address']['address_1']) ) ? $this->session->data['shipping_address']['address_1'] : '';

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/checkout.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/checkout/checkout.tpl';
        } else {
            $this->template = 'default/template/checkout/checkout.tpl';
        }
        $this->response->setOutput($this->load->view($this->template, $data));

    }

    public function addOrder($update = false)
    {

        if ($this->cart->hasShipping()) {
            // Validate if shipping address has been set.
            if (!isset($this->session->data['shipping_address'])) {
                $redirect = $this->url->link('checkout/checkout', '', 'SSL');
            }

            // Validate if shipping method has been set.
            if (!isset($this->session->data['shipping_method'])) {
                $redirect = $this->url->link('checkout/checkout', '', 'SSL');
            }
        } else {
            unset($this->session->data['shipping_address']);
            unset($this->session->data['shipping_method']);
            unset($this->session->data['shipping_methods']);
        }

//        var_dump($this->session->data['shipping_address']);

        $customer_info = false;
        $address_info = false;
        if ($this->customer->isLogged()) {
            $this->load->model('account/address');
            $this->load->model('account/customer');

            $customer_info = $this->model_account_customer->getCustomer($this->customer->getId());
            $address_info = $this->model_account_address->getAddress($customer_info['address_id']);
        }

        if ( !empty($this->session->data['shipping_address']['country_id']) ) {
            $country_id = $this->session->data['shipping_address']['country_id'];
        } elseif ( $this->customer->isLogged() && $address_info ) {
            $country_id = $address_info['country_id'];
        } else {
            $country_id = $this->config->get('config_country_id');
        }

        if ( !empty($this->session->data['shipping_address']['zone_id']) ) {
            $zone_id = $this->session->data['shipping_address']['zone_id'];
        } elseif ( $this->customer->isLogged() && $address_info ) {
            $zone_id = $address_info['zone_id'];
        } else {
            $zone_id = $this->config->get('config_zone_id');
        }

        $order_data = array();

        $order_data['totals'] = array();
        $total = 0;
        $taxes = $this->cart->getTaxes();

        $this->load->model('extension/extension');

        $sort_order = array();

        $results = $this->model_extension_extension->getExtensions('total');

        foreach ($results as $key => $value) {
            $sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
        }

        array_multisort($sort_order, SORT_ASC, $results);

        foreach ($results as $result) {
            if ($this->config->get($result['code'] . '_status')) {
                $this->load->model('total/' . $result['code']);

                $this->{'model_total_' . $result['code']}->getTotal($order_data['totals'], $total, $taxes);
            }
        }

        $sort_order = array();

        foreach ($order_data['totals'] as $key => $value) {
            $sort_order[$key] = $value['sort_order'];
        }

        array_multisort($sort_order, SORT_ASC, $order_data['totals']);

        $this->load->language('checkout/checkout');

        $order_data['invoice_prefix'] = $this->config->get('config_invoice_prefix');
        $order_data['store_id'] = $this->config->get('config_store_id');
        $order_data['store_name'] = $this->config->get('config_name');

        if ($order_data['store_id']) {
            $order_data['store_url'] = $this->config->get('config_url');
        } else {
            $order_data['store_url'] = HTTP_SERVER;
        }

        $this->load->model('localisation/country');

        $country_info = $this->model_localisation_country->getCountry($country_id);

        if ($country_info) {
            $this->session->data['payment_address']['country_id'] = $country_info['country_id'];
            $this->session->data['payment_address']['country'] = $country_info['name'];
            $this->session->data['payment_address']['iso_code_2'] = $country_info['iso_code_2'];
            $this->session->data['payment_address']['iso_code_3'] = $country_info['iso_code_3'];
            $this->session->data['payment_address']['address_format'] = $country_info['address_format'];
        } else {
            $this->session->data['payment_address']['country_id'] = '';
            $this->session->data['payment_address']['country'] = '';
            $this->session->data['payment_address']['iso_code_2'] = '';
            $this->session->data['payment_address']['iso_code_3'] = '';
            $this->session->data['payment_address']['address_format'] = '';
        }

        $this->load->model('localisation/zone');

        $zone_info = $this->model_localisation_zone->getZone($zone_id);

        if ($zone_info) {
            $this->session->data['payment_address']['zone_id'] = $zone_info['zone_id'];
            $this->session->data['payment_address']['zone'] = $zone_info['name'];
            $this->session->data['payment_address']['zone_code'] = $zone_info['code'];
        } else {
            $this->session->data['payment_address']['zone_id'] = '';
            $this->session->data['payment_address']['zone'] = '';
            $this->session->data['payment_address']['zone_code'] = '';
        }

        if ($this->customer->isLogged()) {

            $order_data['customer_id'] = $this->customer->getId();
            $order_data['customer_group_id'] = $customer_info['customer_group_id'];
            $order_data['firstname'] = (!empty($this->session->data['guest']['firstname'])) ? $this->session->data['guest']['firstname'] : $customer_info['firstname'];
            $order_data['lastname'] = (!empty($this->session->data['guest']['lastname'])) ? $this->session->data['guest']['lastname'] : $customer_info['lastname'];
            $order_data['email'] = (!empty($this->session->data['guest']['email'])) ? $this->session->data['guest']['email'] : $customer_info['email'];
            $order_data['telephone'] = (!empty($this->session->data['guest']['telephone'])) ? $this->session->data['guest']['telephone'] : $customer_info['telephone'];
            $order_data['fax'] = $customer_info['fax'];
            $order_data['custom_field'] = unserialize($customer_info['custom_field']);

            $order_data['payment_firstname'] = $order_data['firstname'];
            $order_data['payment_lastname'] = $order_data['lastname'];

            $order_data['payment_company'] = $address_info['company'];
            $order_data['payment_address_1'] = $address_info['address_1'];
            $order_data['payment_address_2'] = $address_info['address_2'];
            $order_data['payment_city'] = $address_info['city'];
            $order_data['payment_postcode'] = $address_info['postcode'];

        } elseif (isset($this->session->data['guest'])) {

            $order_data['customer_id'] = 0;
            $order_data['customer_group_id'] = (!empty($this->session->data['guest']['customer_group_id'])) ? $this->session->data['guest']['customer_group_id'] : 1;
            $order_data['firstname'] = (!empty($this->session->data['guest']['firstname'])) ? $this->session->data['guest']['firstname'] : '';
            $order_data['lastname'] = (!empty($this->session->data['guest']['lastname'])) ? $this->session->data['guest']['lastname'] : '';
            $order_data['email'] = (!empty($this->session->data['guest']['email'])) ? $this->session->data['guest']['email'] : '';
            $order_data['telephone'] = (!empty($this->session->data['guest']['telephone'])) ? $this->session->data['guest']['telephone'] : '';
            $order_data['fax'] = (!empty($this->session->data['guest']['fax'])) ? $this->session->data['guest']['fax'] : '';
            $order_data['custom_field'] = (!empty($this->session->data['guest']['custom_field'])) ? $this->session->data['guest']['custom_field'] : '';

            $order_data['payment_firstname'] = (!empty($this->session->data['guest']['firstname'])) ? $this->session->data['guest']['firstname'] : '';
            $order_data['payment_lastname'] = (!empty($this->session->data['guest']['lastname'])) ? $this->session->data['guest']['lastname'] : '';

            $order_data['payment_company'] = (!empty($this->session->data['payment_address']['company'])) ? $this->session->data['payment_address']['company'] : '';
            $order_data['payment_address_1'] = (!empty($this->session->data['payment_address']['address_1'])) ? $this->session->data['payment_address']['address_1'] : '';
            $order_data['payment_address_2'] = (!empty($this->session->data['payment_address']['address_2'])) ? $this->session->data['payment_address']['address_2'] : '';
            $order_data['payment_city'] = (!empty($this->session->data['payment_address']['city'])) ? $this->session->data['payment_address']['city'] : '';
            $order_data['payment_postcode'] = (!empty($this->session->data['payment_address']['postcode'])) ? $this->session->data['payment_address']['postcode'] : '';
            $order_data['payment_country'] = $this->model_localisation_country->getCountry($this->config->get('config_country_id'))['name'];

        }

        $order_data['payment_country'] = $this->model_localisation_country->getCountry($country_id)['name'];
        $order_data['payment_country_id'] = $country_id;
        $order_data['payment_zone'] = $this->model_localisation_zone->getZone($zone_id)['name'];
        $order_data['payment_zone_id'] = $zone_id;
        
        $order_data['payment_address_format'] = $this->session->data['payment_address']['address_format'];
        $order_data['payment_custom_field'] = (isset($this->session->data['payment_address']['custom_field']) ? $this->session->data['payment_address']['custom_field'] : array());

        if (isset($this->session->data['payment_method']['title'])) {
            $order_data['payment_method'] = $this->session->data['payment_method']['title'];
        } else {
            $order_data['payment_method'] = '';
        }

        if (isset($this->session->data['payment_method']['code'])) {
            $order_data['payment_code'] = $this->session->data['payment_method']['code'];
        } else {
            $order_data['payment_code'] = '';
        }

        if ($this->cart->hasShipping()) {

            $this->session->data['shipping_address'] = array(
                'firstname'     => $order_data['firstname'],
                'lastname'      => $order_data['lastname'],
                'company'       => $order_data['payment_company'],
                'address_1'     => ( !empty($this->session->data['shipping_address']['address_1']) ) ? $this->session->data['shipping_address']['address_1'] : $order_data['payment_address_1'],
                'address_2'     => ( !empty($this->session->data['shipping_address']['address_2']) ) ? $this->session->data['shipping_address']['address_2'] : $order_data['payment_address_2'],
                'city'          => ( !empty($this->session->data['shipping_address']['city']) ) ? $this->session->data['shipping_address']['city'] : $order_data['payment_city'],
                'city_ref'      => ( !empty($this->session->data['shipping_address']['city_ref']) ) ? $this->session->data['shipping_address']['city_ref'] : '',
                'postcode'      => $order_data['payment_postcode'],
                'zone'          => ( !empty($this->session->data['shipping_address']['zone']) ) ? $this->session->data['shipping_address']['zone'] : $order_data['payment_zone'],
                'zone_id'       => ( !empty($this->session->data['shipping_address']['zone_id']) ) ? $this->session->data['shipping_address']['zone_id'] : $order_data['payment_zone_id'],
                'zone_ref'      => ( !empty($this->session->data['shipping_address']['zone_ref']) ) ? $this->session->data['shipping_address']['zone_ref'] : '',
                'country'       => $order_data['payment_country'],
                'country_id'    => $order_data['payment_country_id'],
                'address_format' => $this->session->data['payment_address']['address_format'],

                'street'            => (!empty($this->session->data['shipping_address']['street'])) ? $this->session->data['shipping_address']['street'] : '',
                'house'             => (!empty($this->session->data['shipping_address']['house'])) ? $this->session->data['shipping_address']['house'] : '',
                'apartment'         => (!empty($this->session->data['shipping_address']['apartment'])) ? $this->session->data['shipping_address']['apartment'] : ''
            );

            $order_data['shipping_firstname'] = $this->session->data['shipping_address']['firstname'];
            $order_data['shipping_lastname'] = $this->session->data['shipping_address']['lastname'];
            $order_data['shipping_company'] = $this->session->data['shipping_address']['company'];
            $order_data['shipping_address_1'] = $this->session->data['shipping_address']['address_1'];
            $order_data['shipping_address_2'] = $this->session->data['shipping_address']['address_2'];
            $order_data['shipping_city'] = $this->session->data['shipping_address']['city'];
            $order_data['shipping_postcode'] = $this->session->data['shipping_address']['postcode'];
            $order_data['shipping_zone'] = $this->session->data['shipping_address']['zone'];
            $order_data['shipping_zone_id'] = $this->session->data['shipping_address']['zone_id'];
            $order_data['shipping_zone_ref'] = $this->session->data['shipping_address']['zone_ref'];
            $order_data['shipping_country'] = $this->session->data['shipping_address']['country'];
            $order_data['shipping_country_id'] = $this->session->data['shipping_address']['country_id'];
            $order_data['shipping_address_format'] = $this->session->data['shipping_address']['address_format'];
            $order_data['shipping_custom_field'] = (isset($this->session->data['shipping_address']['custom_field']) ? $this->session->data['shipping_address']['custom_field'] : array());

            if (isset($this->session->data['shipping_method']['title'])) {
                $order_data['shipping_method'] = $this->session->data['shipping_method']['title'];
            } else {
                $order_data['shipping_method'] = '';
            }

            if (isset($this->session->data['shipping_method']['code'])) {
                $order_data['shipping_code'] = $this->session->data['shipping_method']['code'];
            } else {
                $order_data['shipping_code'] = '';
            }
        } else {
            $order_data['shipping_firstname'] = '';
            $order_data['shipping_lastname'] = '';
            $order_data['shipping_company'] = '';
            $order_data['shipping_address_1'] = '';
            $order_data['shipping_address_2'] = '';
            $order_data['shipping_city'] = '';
            $order_data['shipping_postcode'] = '';
            $order_data['shipping_zone'] = '';
            $order_data['shipping_zone_id'] = '';
            $order_data['shipping_country'] = '';
            $order_data['shipping_country_id'] = '';
            $order_data['shipping_address_format'] = '';
            $order_data['shipping_custom_field'] = array();
            $order_data['shipping_method'] = '';
            $order_data['shipping_code'] = '';
        }

        $order_data['products'] = array();

        foreach ($this->cart->getProducts() as $product) {
            $option_data = array();

            foreach ($product['option'] as $option) {
                $option_data[] = array(
                    'product_option_id' => $option['product_option_id'],
                    'product_option_value_id' => $option['product_option_value_id'],
                    'option_id' => $option['option_id'],
                    'option_value_id' => $option['option_value_id'],
                    'name' => $option['name'],
                    'value' => $option['value'],
                    'type' => $option['type']
                );
            }

            $order_data['products'][] = array(
                'product_id' => $product['product_id'],
                'name' => $product['name'],
                'model' => $product['model'],
                'option' => $option_data,
                'download' => $product['download'],
                'quantity' => $product['quantity'],
                'subtract' => $product['subtract'],
                'price' => $product['price'],
                'total' => $product['total'],
                'tax' => $this->tax->getTax($product['price'], $product['tax_class_id']),
                'reward' => $product['reward']
            );
        }

        $order_data['comment'] = (!empty($this->session->data['comment'])) ? $this->session->data['comment'] : '';
        $order_data['total'] = $total;

        if (isset($this->request->cookie['tracking'])) {
            $order_data['tracking'] = $this->request->cookie['tracking'];

            $subtotal = $this->cart->getSubTotal();

            // Affiliate
            $this->load->model('affiliate/affiliate');

            $affiliate_info = $this->model_affiliate_affiliate->getAffiliateByCode($this->request->cookie['tracking']);

            if ($affiliate_info) {
                $order_data['affiliate_id'] = $affiliate_info['affiliate_id'];
                $order_data['commission'] = ($subtotal / 100) * $affiliate_info['commission'];
            } else {
                $order_data['affiliate_id'] = 0;
                $order_data['commission'] = 0;
            }

            // Marketing
            $this->load->model('checkout/marketing');

            $marketing_info = $this->model_checkout_marketing->getMarketingByCode($this->request->cookie['tracking']);

            if ($marketing_info) {
                $order_data['marketing_id'] = $marketing_info['marketing_id'];
            } else {
                $order_data['marketing_id'] = 0;
            }
        } else {
            $order_data['affiliate_id'] = 0;
            $order_data['commission'] = 0;
            $order_data['marketing_id'] = 0;
            $order_data['tracking'] = '';
        }

        $order_data['language_id'] = $this->config->get('config_language_id');
        $order_data['currency_id'] = $this->currency->getId();
        $order_data['currency_code'] = $this->currency->getCode();
        $order_data['currency_value'] = $this->currency->getValue($this->currency->getCode());
        $order_data['ip'] = $this->request->server['REMOTE_ADDR'];

        if (!empty($this->request->server['HTTP_X_FORWARDED_FOR'])) {
            $order_data['forwarded_ip'] = $this->request->server['HTTP_X_FORWARDED_FOR'];
        } elseif (!empty($this->request->server['HTTP_CLIENT_IP'])) {
            $order_data['forwarded_ip'] = $this->request->server['HTTP_CLIENT_IP'];
        } else {
            $order_data['forwarded_ip'] = '';
        }

        if (isset($this->request->server['HTTP_USER_AGENT'])) {
            $order_data['user_agent'] = $this->request->server['HTTP_USER_AGENT'];
        } else {
            $order_data['user_agent'] = '';
        }

        if (isset($this->request->server['HTTP_ACCEPT_LANGUAGE'])) {
            $order_data['accept_language'] = $this->request->server['HTTP_ACCEPT_LANGUAGE'];
        } else {
            $order_data['accept_language'] = '';
        }

        $this->load->model('checkout/order');

        if ( empty($this->session->data['order_id']) ) {
            $this->session->data['order_id'] = $this->model_checkout_order->addOrder($order_data);
        } elseif (!$update) {
            $order_id = (int)$this->session->data['order_id'];
            $this->model_checkout_order->editOrder($order_id, $order_data);
        } else {
            $order_id = (int)$this->session->data['order_id'];
            $this->model_checkout_order->updateOrder($order_id, $order_data);
        }

    }
    
    public function updateOrder()
    {
        $this->addOrder(true);
    }

    public function updateSession()
    {

        $customer_info = array();

        if ($this->customer->isLogged()) {
            $this->load->model('account/customer');
            $customer_info = $this->model_account_customer->getCustomer($this->customer->getId());
        }

        if ($this->customer->isLogged()) {
            $this->session->data['guest']['customer_group_id'] = $customer_info['customer_group_id'];
        } else {
            $this->session->data['guest']['customer_group_id'] = $this->config->get('config_customer_group_id');
        }

    }

    public function updateShipping() {

        unset($this->session->data['shipping_address']['address_1']);
        unset($this->session->data['shipping_address']['address_2']);

        $json = array();

        $ref = (!empty($this->request->post['city_ref'])) ? $this->db->escape($this->request->post['city_ref']) : false;

        foreach ($this->request->post as $key => $value) {
            switch ($key) {
                case 'city':
                    $this->session->data['shipping_address']['city'] = strip_tags(html_entity_decode($value, ENT_QUOTES, 'UTF-8'));
                    break;
                case 'city_ref':
                    $this->session->data['shipping_address']['city_ref'] = strip_tags(html_entity_decode($value, ENT_QUOTES, 'UTF-8'));
                    break;
                case 'address_1':
                    $this->session->data['shipping_address']['address_1'] = strip_tags(html_entity_decode($value, ENT_QUOTES, 'UTF-8'));
                    break;
                case 'address_2':
                    $address_2 = false;
                    foreach ($value as $k => $v) {
                        switch ($k) {
                            case 'street':
                                $this->session->data['shipping_address']['street'] = strip_tags(html_entity_decode($v, ENT_QUOTES, 'UTF-8'));
                                $address_2 = $v . ', ';
                                break;
                            case 'house':
                                $this->session->data['shipping_address']['house'] = strip_tags(html_entity_decode($v, ENT_QUOTES, 'UTF-8'));
                                $address_2 .= $this->language->get('text_address_house') . $v . ', ';
                                break;
                            case 'apartment':
                                $this->session->data['shipping_address']['apartment'] = strip_tags(html_entity_decode($v, ENT_QUOTES, 'UTF-8'));
                                $address_2 .= $this->language->get('text_address_apartment') . $v . '.';
                                break;
                        }
                    }

                    $this->session->data['shipping_address']['address_2'] = strip_tags(html_entity_decode($address_2, ENT_QUOTES, 'UTF-8'));
                    break;
            }
        }

        $this->load->model('localisation/location');

//        var_dump($this->session->data['shipping_method']);

        $sql_db = 'novaposhta_warehouses';
        if ( !empty($this->session->data['shipping_method']['sql_db']) ) {
            $sql_db = $this->db->escape($this->session->data['shipping_method']['sql_db']);
        }

        $novaposhta_warehouses_info = $this->model_localisation_location->getWarehouseByCity($ref, $sql_db);

        if ($novaposhta_warehouses_info && $this->session->data['shipping_method']['code'] != 'flat.flat') {
            $json['address'] = array();
            $this->load->model('localisation/zone');
            foreach ($novaposhta_warehouses_info as $info) {
                $json['address'][] = array(
                    'address_id'    => $info['id'],
                    'name'          => $info['name']
                );
            }
        } else {
            $json['address'] = $this->session->data['shipping_address'];
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    // shippingMethods

    // saveShippingMethods

    // paymentMethods

    // savePaymentMethods

}