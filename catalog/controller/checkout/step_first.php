<?php
class ControllerCheckoutStepFirst extends Controller
{

    private $error = array();

    public function index()
    {
//        echo '<pre>';
//        print_r($this->session->data['shipping_address']);
//        echo '</pre>';

        $this->load->model('localisation/zone');
        $this->load->model('localisation/country');

        if ( $this->request->server['REQUEST_METHOD'] == 'POST' && ( !empty($this->request->post['step_second']) ) ) {
            unset($this->session->data['guest']['step_second']);
        }

        $this->load->language('checkout/step_one');

        $data['logged'] = $this->customer->isLogged();

        if ( isset($this->session->data['account']) ) {
            $data['account'] = $this->session->data['account'];
        } else {
            $data['account'] = '';
        }

        if ( !empty($this->session->data['customer']) ) {
            $data['customer'] = true;
        } else {
            $data['customer'] = false;
        }

        if ( !empty($this->session->data['guest']['step_second']) ) {
            $data['step_second'] = true;
        } else {
            $data['step_second'] = false;
        }

        $data['text_title'] = $this->language->get('text_title');

        $data['text_new_customer'] = $this->language->get('text_new_customer');
        $data['text_old_customer'] = $this->language->get('text_old_customer');
        $data['text_reg_customer'] = $this->language->get('text_reg_customer');

        $data['text_edit'] = $this->language->get('text_edit');
        $data['text_forgotten'] = $this->language->get('text_forgotten');
        $data['text_next_step'] = $this->language->get('text_next_step');

        $data['text_none'] = $this->language->get('text_none');

        $data['text_example'] = $this->language->get('text_example');
        $data['text_next_step'] = $this->language->get('text_next_step');
        $data['text_example_city'] = $this->language->get('text_example_city');
        $data['text_example_country'] = $this->language->get('text_example_country');

        $data['entry_firstname'] = $this->language->get('entry_firstname');
        $data['entry_city'] = $this->language->get('entry_city');
        $data['entry_country'] = $this->language->get('entry_country');
        $data['entry_telephone'] = $this->language->get('entry_telephone');
        $data['entry_email'] = $this->language->get('entry_email');
        $data['entry_password'] = $this->language->get('entry_password');
        $data['entry_confirm'] = $this->language->get('entry_confirm');

        $data['button_login'] = $this->language->get('button_login');
        $data['button_next'] = $this->language->get('button_next');
        $data['button_loading'] = $this->language->get('button_loading');

        $customer_info = array();

        if ( $this->customer->isLogged() ) {
            $this->load->model('account/customer');
            $customer_info = $this->model_account_customer->getCustomer($this->customer->getId());
        }

        if ( $this->customer->isLogged() ) {
            $data['customer_group_id'] = $customer_info['customer_group_id'];
        } elseif (isset($this->session->data['guest']['customer_group_id'])) {
            $data['customer_group_id'] = $this->session->data['guest']['customer_group_id'];
        } else {
            $data['customer_group_id'] = $this->config->get('config_customer_group_id');
        }

        if ( isset($this->session->data['guest']['firstname']) ) {
            $data['firstname'] = $this->session->data['guest']['firstname'];
        } elseif ( $this->customer->isLogged() ) {
            $data['firstname'] = $customer_info['firstname'];
        } else {
            $data['firstname'] = '';
        }

        $config_zone_id = $this->config->get('config_zone_id');
        if ( !empty($this->session->data['shipping_address']['zone_id']) ) {
            $data['zone_id'] = $this->session->data['shipping_address']['zone_id'];
        } elseif ( !empty($config_zone_id) ) {
            $data['zone_id'] = $this->config->get('config_zone_id');
        } else {
            $data['zone_id'] = '';
        }

        if ( !empty($this->session->data['shipping_address']['zone']) ) {
            $data['zone'] = $this->session->data['shipping_address']['zone'];
        } else {
            $data['zone'] = $this->model_localisation_zone->getZone($data['zone_id'])['name'];
        }

        if ( !empty($this->session->data['shipping_address']['zone_ref']) ) {
            $data['zone_ref'] = $this->session->data['shipping_address']['zone_ref'];
        } else {
            $this->session->data['shipping_address']['zone_ref'] = $this->model_localisation_zone->getZoneRef($data['zone_id'])['ref'];
            $data['zone_ref'] = $this->model_localisation_zone->getZoneRef($data['zone_id'])['ref'];
        }

        $config_country_id = $this->config->get('config_country_id');
        if ( !empty($this->session->data['shipping_address']['country_id']) ) {
            $data['country_id'] = $this->session->data['shipping_address']['country_id'];
        } elseif ( !empty($config_country_id) ) {
            $data['country_id'] = $this->config->get('config_country_id');
        } else {
            $data['country_id'] = '';
        }

        if ( !empty($this->session->data['shipping_address']['country']) ) {
            $data['country'] = $this->session->data['shipping_address']['country'];
        } else {
            $data['country'] = $this->model_localisation_country->getCountry($data['country_id'])['name'];
        }

        if ( isset($this->session->data['guest']['telephone']) ) {
            $data['telephone'] = $this->session->data['guest']['telephone'];
        } elseif ( $this->customer->isLogged() ) {
            $data['telephone'] = $customer_info['telephone'];
        } else {
            $data['telephone'] = '';
        }

        if ( isset($this->session->data['guest']['email']) ) {
            $data['email'] = $this->session->data['guest']['email'];
        } elseif ( $this->customer->isLogged() ) {
            $data['email'] = $customer_info['email'];
        } else {
            $data['email'] = '';
        }

        $data['forgotten'] = $this->url->link('account/forgotten', '', 'SSL');

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/step_first.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/checkout/step_first.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/template/checkout/step_first.tpl', $data));
        }

    }

    public function account() {

        if ( $this->request->server['REQUEST_METHOD'] == 'POST' ) {
            if ( !empty($this->request->post['account']) ) {
                $this->session->data['account'] = 'register';
            } else {
                $this->session->data['account'] = 'guest';
            }
        }

        $this->index();

    }

    public function customer() {

        if ( $this->request->server['REQUEST_METHOD'] == 'POST' ) {
            if ( !empty($this->request->post['customer']) ) {
                $this->session->data['customer'] = true;
            } else {
                $this->session->data['customer'] = false;
            }
        }

        $this->index();

    }

    public function update() {

        $json = array();

        $this->load->language('checkout/step_one');

        if ( $this->request->server['REQUEST_METHOD'] == 'POST' && $this->validateField($this->request->post) ) {

            foreach ($this->request->post as $key => $value) {
                switch ($key) {
                    case 'firstname':
                        $this->session->data['guest']['firstname'] = strip_tags(html_entity_decode($value, ENT_QUOTES, 'UTF-8'));
                        break;
                    case 'telephone':
                        $this->session->data['guest']['telephone'] = strip_tags(html_entity_decode($value, ENT_QUOTES, 'UTF-8'));
                        break;
                    case 'email':
                        $this->session->data['guest']['email'] = strip_tags(html_entity_decode($value, ENT_QUOTES, 'UTF-8'));
                        break;
                    case 'password':
                        $this->session->data['guest']['password'] = html_entity_decode($value, ENT_QUOTES, 'UTF-8');
                        break;
                    case 'comment':
                        $this->session->data['comment'] = html_entity_decode($value, ENT_QUOTES, 'UTF-8');
                        break;
                }
            }

            $json['success'] = true;

        }

        if ( isset($this->error['firstname']) ) {
            $json['error']['firstname'] = $this->error['firstname'];
        }

        if ( isset($this->error['telephone']) ) {
            $json['error']['telephone'] = $this->error['telephone'];
        }

        if ( isset($this->error['email']) ) {
            $json['error']['email'] = $this->error['email'];
        }

        if (isset($this->error['password'])) {
            $json['error']['password'] = $this->error['password'];
        }

        if (isset($this->error['confirm'])) {
            $json['error']['confirm'] = $this->error['confirm'];
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));

    }
    
    protected function validateField($data = array()) {

        $this->load->model('account/customer');

        foreach ($data as $key => $value) {
            switch ($key) {
                case 'firstname':
                    if ( preg_match("/[0-9()]/", $value) ) {
                        $this->error['firstname'] = $this->language->get('error_name');
                    }

                    if ( (utf8_strlen($value) < 2) || (utf8_strlen($value) > 42) ) {
                        $this->error['firstname'] = $this->language->get('error_name');
                    }
                    break;
                case 'telephone':
                    if ( (utf8_strlen($value) < 7) || (utf8_strlen($value) > 32) ) {
                        $this->error['telephone'] = $this->language->get('error_telephone');
                    }

                    if ( !preg_match('/^[0-9]+$/i', $value) ) {
                        $this->error['telephone'] = $this->language->get('error_telephone');
                    }
                    break;
                case 'email':
                    if ( !preg_match('/.+@.+\..+/i', $value) ) {
                        $this->error['email'] = $this->language->get('error_email');
                    }
                    if ( $this->model_account_customer->getTotalCustomersByEmail($value) ) {
                        $this->error['email'] = $this->language->get('error_exists');
                    }
                    break;
                case 'password':
                    if ( (utf8_strlen($value) < 4) || (utf8_strlen($value) > 20)) {
                        $this->error['password'] = $this->language->get('error_password');
                    }
                    break;
                case 'confirm':
                    if ( !empty($this->session->data['guest']['password']) && ( $value != $this->session->data['guest']['password'] ) ) {
                        $this->error['confirm'] = $this->language->get('error_confirm');
                    }
                    break;
            }
        }
        
        return !$this->error;
        
    }

}