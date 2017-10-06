<?php
class ControllerCheckoutHeader extends Controller
{

    public function index()
    {

        $this->load->language('checkout/checkout');

        $data['title'] = $this->language->get('heading_title');
        $data['lang'] = $this->language->get('code');
        $data['direction'] = $this->language->get('direction');
        $data['text_work_time'] = $this->language->get('text_work_time');
        $data['text_work_time1'] = $this->language->get('text_work_time1');
        $data['popup_work_time'] = html_entity_decode($this->config->get('config_cart_schedule'));
        $data['telephone'] = $this->config->get('config_telephone');
        $data['telephone_2'] = $this->config->get('config_telephone_2');
        $data['telephone_3'] = $this->config->get('config_telephone_3');

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/header.tpl')) {
            return $this->load->view($this->config->get('config_template') . '/template/checkout/header.tpl', $data);
        } else {
            return $this->load->view('default/template/checkout/header.tpl', $data);
        }

    }

}