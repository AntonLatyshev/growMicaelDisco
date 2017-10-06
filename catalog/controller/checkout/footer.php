<?php
class ControllerCheckoutFooter extends Controller
{

    public function index()
    {

        $data = array();

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/footer.tpl')) {
            return $this->load->view($this->config->get('config_template') . '/template/checkout/footer.tpl', $data);
        } else {
            return $this->load->view('default/template/checkout/footer.tpl', $data);
        }

    }

}