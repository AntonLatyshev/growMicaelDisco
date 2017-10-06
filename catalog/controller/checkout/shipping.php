<?php
class ControllerCheckoutShipping extends Controller
{

    private $error = array();

    public function shippingMethods()
    {

        $this->load->language('checkout/checkout');

        if (isset($this->session->data['shipping_address'])) {
            // Shipping Methods
            $method_data = array();

            $this->load->model('extension/extension');

            $this->load->model('localisation/location');

            $results = $this->model_extension_extension->getExtensions('shipping');

            $cities = $this->model_localisation_location->getCities($this->session->data['shipping_address']['zone_ref']);

            foreach ($results as $result) {
                if ($this->config->get($result['code'] . '_status')) {
                    $this->load->model('shipping/' . $result['code']);

                    $quote = $this->{'model_shipping_' . $result['code']}->getQuote($this->session->data['shipping_address']);

                    $configs = array();
                    if (!empty($quote['config'])) {
                        $configs = $quote['config'];
                    }

                    $data_fields = array(
                        'cities'            => $cities,
                        'shipping_address_fields' => $configs,
                        'entry_city'        => $this->language->get('entry_city'),
                        'entry_address_1'   => $this->language->get('entry_address_1'),
                        'entry_address_2'   => $this->language->get('entry_address_2'),
                        'entry_house'       => $this->language->get('entry_house'),
                        'entry_apartment'   => $this->language->get('entry_apartment'),
                        'text_select'       => $this->language->get('text_select'),
                        'city'              => ( !empty($this->session->data['shipping_address']['city']) ) ? $this->session->data['shipping_address']['city'] : '',
                        'city_ref'          => ( !empty($this->session->data['shipping_address']['city_ref']) ) ? $this->session->data['shipping_address']['city_ref'] : '',
                        'address_1'         => ( !empty($this->session->data['shipping_address']['address_1']) ) ? $this->session->data['shipping_address']['address_1'] : '',
                        'address_2'         => ( !empty($this->session->data['shipping_address']['address_2']) ) ? $this->session->data['shipping_address']['address_2'] : '',
                        'street'            => (!empty($this->session->data['shipping_address']['street'])) ? $this->session->data['shipping_address']['street'] : '',
                        'house'             => (!empty($this->session->data['shipping_address']['house'])) ? $this->session->data['shipping_address']['house'] : '',
                        'apartment'         => (!empty($this->session->data['shipping_address']['apartment'])) ? $this->session->data['shipping_address']['apartment'] : ''
                    );

                    if ($quote) {
                        $method_data[$result['code']] = array(
                            'title'         => $quote['title'],
                            'quote'         => $quote['quote'],
                            'sort_order'    => $quote['sort_order'],
                            'error'         => $quote['error'],
                            'fields'        => $this->load->view('default/template/checkout/shipping_address.tpl', $data_fields)
                        );
                    }
                }
            }

            $sort_order = array();

            foreach ($method_data as $key => $value) {
                $sort_order[$key] = $value['sort_order'];
            }

            array_multisort($sort_order, SORT_ASC, $method_data);

            $this->session->data['shipping_methods'] = $method_data;
        }

        $data['text_shipping_method'] = $this->language->get('text_shipping_method');
        $data['text_comments'] = $this->language->get('text_comments');
        $data['text_loading'] = $this->language->get('text_loading');

        $data['button_continue'] = $this->language->get('button_continue');

        if (empty($this->session->data['shipping_methods'])) {
            $data['error_warning'] = sprintf($this->language->get('error_no_shipping'), $this->url->link('information/contact'));
        } else {
            $data['error_warning'] = '';
        }

        if (isset($this->session->data['shipping_methods'])) {
            $data['shipping_methods'] = $this->session->data['shipping_methods'];
        } else {
            $data['shipping_methods'] = array();
        }

        if (isset($this->session->data['shipping_method']['code'])) {
            $data['code'] = $this->session->data['shipping_method']['code'];
        } else {
            $data['code'] = '';
        }

        if (isset($this->session->data['comment'])) {
            $data['comment'] = $this->session->data['comment'];
        } else {
            $data['comment'] = '';
        }

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/shipping.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/checkout/shipping.tpl';
        } else {
            $this->template = 'default/template/checkout/shipping.tpl';
        }

        $this->response->setOutput($this->load->view($this->template, $data));

    }

    public function saveShippingMethods()
    {
        $this->load->language('checkout/checkout');

        $json = array();

        // Validate if shipping is required. If not the customer should not have reached this page.
        if (!$this->cart->hasShipping()) {
            $json['redirect'] = $this->url->link('checkout/checkout', '', 'SSL');
        }

        // Validate if shipping address has been set.
        if (!isset($this->session->data['shipping_address'])) {
            $json['redirect'] = $this->url->link('checkout/checkout', '', 'SSL');
        }

        // Validate cart has products and has stock.
        if ((!$this->cart->hasProducts() && empty($this->session->data['vouchers'])) || (!$this->cart->hasStock() && !$this->config->get('config_stock_checkout'))) {
            $json['redirect'] = $this->url->link('checkout/checkout');
        }

        // Validate minimum quantity requirements.
        $products = $this->cart->getProducts();

        foreach ($products as $product) {
            $product_total = 0;

            foreach ($products as $product_2) {
                if ($product_2['product_id'] == $product['product_id']) {
                    $product_total += $product_2['quantity'];
                }
            }

            if ($product['minimum'] > $product_total) {
                $json['redirect'] = $this->url->link('checkout/checkout');

                break;
            }
        }

        if (!isset($this->request->post['shipping_method'])) {
            $json['error']['warning'] = $this->language->get('error_shipping');
        } else {
            $shipping = explode('.', $this->request->post['shipping_method']);

            if (!isset($shipping[0]) || !isset($shipping[1]) || !isset($this->session->data['shipping_methods'][$shipping[0]]['quote'][$shipping[1]])) {
                $json['error']['warning'] = $this->language->get('error_shipping');
            }
        }

        if (!$json) {
            $this->session->data['shipping_method'] = $this->session->data['shipping_methods'][$shipping[0]]['quote'][$shipping[1]];
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function autoCompleteCountry() {
        $json = array();

        if (isset($this->request->get['filter_name'])) {
            $this->load->model('checkout/shipping');

            $filter_data = array(
                'filter_name' => $this->request->get['filter_name'],
                'start'       => 0,
                'limit'       => 25
            );

            $results = $this->model_checkout_shipping->getCountries($filter_data);

            foreach ($results as $result) {
                $json[] = array(
                    'country_id'    => $result['country_id'],
                    'name'          => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'))
                );
            }
        }

        $sort_order = array();

        foreach ($json as $key => $value) {
            $sort_order[$key] = $value['name'];
        }

        array_multisort($sort_order, SORT_ASC, $json);

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function autoCompleteZone() {
        $json = array();

        if (isset($this->request->get['filter_name'])) {
            $this->load->model('checkout/shipping');

            $filter_data = array(
                'country_id'  => $this->request->get['country_id'],
                'filter_name' => $this->request->get['filter_name'],
                'start'       => 0,
                'limit'       => 25
            );

            $results = $this->model_checkout_shipping->getZones($filter_data);

            if ($results) {
                foreach ($results as $result) {
                    $json[] = array(
                        'zone_id' => $result['zone_id'],
                        'zone_ref' => $result['Ref'],
                        'name' => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'))
                    );
                }
            }
        }

        $sort_order = array();

        foreach ($json as $key => $value) {
            $sort_order[$key] = $value['name'];
        }

        array_multisort($sort_order, SORT_ASC, $json);

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function autoCompleteWarehouses() {
        $json = array();

        if (isset($this->request->get['filter_name'])) {
            $this->load->model('checkout/shipping');

            $filter_data = array(
                'sql_db'      => ( !empty($this->session->data['shipping_method']['sql_db']) ) ? $this->session->data['shipping_method']['sql_db'] : 'novaposhta_warehouses',
                'city_ref'    => $this->request->get['city_ref'],
                'filter_name' => $this->request->get['filter_name'],
                'start'       => 0,
                'limit'       => 25
            );

            $results = $this->model_checkout_shipping->getWarehouseByCity($filter_data);

            foreach ($results as $result) {
                $json[] = array(
                    'id'        => $result['id'],
                    'name'      => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8')),
                    'city'      => strip_tags(html_entity_decode($result['city'], ENT_QUOTES, 'UTF-8')),
                    'log'       => strip_tags(html_entity_decode($result['log'], ENT_QUOTES, 'UTF-8')),
                    'lat'       => strip_tags(html_entity_decode($result['lat'], ENT_QUOTES, 'UTF-8')),
                    'phone'     => strip_tags(html_entity_decode($result['phone'], ENT_QUOTES, 'UTF-8')),
                    'schedule'  => strip_tags(html_entity_decode($result['schedule'], ENT_QUOTES, 'UTF-8'))
                );
            }
        }

        $sort_order = array();

        foreach ($json as $key => $value) {
            $sort_order[$key] = $value['name'];
        }

        array_multisort($sort_order, SORT_ASC, $json);

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function update() {

        $json = array();

        $this->load->language('checkout/step_one');

        if ( $this->request->server['REQUEST_METHOD'] == 'POST' && $this->validateField($this->request->post) ) {

            foreach ($this->request->post as $key => $value) {
                switch ($key) {
                    case 'country_id':
                        $this->session->data['shipping_address']['country_id'] = strip_tags(html_entity_decode($value, ENT_QUOTES, 'UTF-8'));
                        break;
                    case 'country':
                        $this->session->data['shipping_address']['country'] = strip_tags(html_entity_decode($value, ENT_QUOTES, 'UTF-8'));
                        break;
                    case 'zone_id':
                        $this->session->data['shipping_address']['zone_id'] = strip_tags(html_entity_decode($value, ENT_QUOTES, 'UTF-8'));
                        break;
                    case 'zone':
                        $this->session->data['shipping_address']['zone'] = strip_tags(html_entity_decode($value, ENT_QUOTES, 'UTF-8'));
                        break;
                    case 'zone_ref':
                        $this->session->data['shipping_address']['zone_ref'] = strip_tags(html_entity_decode($value, ENT_QUOTES, 'UTF-8'));
                        break;
                }
            }

            $json['success'] = true;

        }

        if ( isset($this->error['country']) ) {
            $json['error']['country'] = $this->error['country'];
        }

        if ( isset($this->error['country_id']) ) {
            $json['error']['country'] = $this->error['country_id'];
        }

        if ( isset($this->error['zone']) ) {
            $json['error']['zone'] = $this->error['zone'];
        }

        if ( isset($this->error['zone_id']) ) {
            $json['error']['zone'] = $this->error['zone_id'];
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));

    }

    protected function validateField($data = array()) {

        foreach ($data as $key => $value) {
            switch ($key) {
                case 'country_id':
                    if ( empty($value) ) {
                        $this->error['country_id'] = $this->language->get('error_country');
                    }
                    break;
                case 'country':
                    if ( empty($value) ) {
                        $this->error['country'] = $this->language->get('error_country');
                    }
                    break;
                case 'zone_id':
                    if ( empty($value) ) {
                        $this->error['zone_id'] = $this->language->get('error_zone');
                    }
                    break;
                case 'zone':
                    if ( empty($value) ) {
                        $this->error['zone'] = $this->language->get('error_zone');
                    }
                    break;
            }
        }

        return !$this->error;

    }

}
