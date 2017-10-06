<?php
class ControllerCheckoutStepSecond extends Controller
{

    private $error = array();

    public function index($data = array())
    {

        $this->load->language('checkout/step_second');
        
        $data['text_heading'] = $this->language->get('text_heading');
        $data['text_delivery'] = $this->language->get('text_delivery');
        $data['text_payment'] = $this->language->get('text_payment');

        $data['text_info_delivery'] = $this->config->get('config_cart_description_shipping');
        $data['text_info_payment'] = $this->config->get('config_cart_description_payment');

        $data['text_comments'] = $this->language->get('text_comments');
        $data['text_info_comments'] = $this->config->get('config_cart_description_comment');

        $data['comment'] = ( !empty($this->session->data['comment']) ) ? $this->session->data['comment'] : '';

        if ( $this->validateField($this->session->data['guest']) ) {

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/step_second.tpl')) {
                $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/checkout/step_second.tpl', $data));
            } else {
                $this->response->setOutput($this->load->view('default/template/checkout/step_second.tpl', $data));
            }
            
        }

    }

    public function validate() {

        $json = array();

        $this->load->language('checkout/step_second');

        if ( $this->request->server['REQUEST_METHOD'] == 'POST' && $this->validateField($this->request->post) ) {

            $json['success'] = true;

            /**
             * Update session
             **/
            $this->session->data['guest']['step_second'] = true;

        }

        if ( isset($this->error['country']) ) {
            $json['error']['country'] = $this->error['country'];
        }

        if ( isset($this->error['zone']) ) {
            $json['error']['zone'] = $this->error['zone'];
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
                case 'country':
                    if ( !isset($value) || $value == '' ) {
                        $this->error['country'] = $this->language->get('error_country');
                    }
                    break;
                case 'zone':
                    if ( !isset($value) || $value == '' ) {
                        $this->error['zone'] = $this->language->get('error_zone');
                    }
                    break;
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