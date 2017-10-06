<?php
class ControllerSaleNovaposhta extends Controller {
    private $error = array();

    public function index() {
        $this->load->language('sale/novaposhta');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('sale/novaposhta');

        $this->load->model('setting/setting');

        if ( ($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate() ) {

            if ( !empty($this->request->post['config_novaposhta_key']) ) {
                $this->model_setting_setting->editSettingValue('config', 'config_novaposhta_key', $this->request->post['config_novaposhta_key']);
            }

            $this->session->data['success'] = $this->language->get('text_success');

            $this->response->redirect($this->url->link('sale/novaposhta', 'token=' . $this->session->data['token'], 'SSL'));
        }

        $this->getList();
    }

    public function getList() {

        $data = array();

        $data['token'] = $this->session->data['token'];

        if (isset($this->error['key'])) {
            $data['error_warning'] = $this->error['key'];
        } else {
            $data['error_warning'] = '';
        }

        if (isset($this->session->data['success'])) {
            $data['success'] = $this->session->data['success'];

            unset($this->session->data['success']);
        } else {
            $data['success'] = '';
        }

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_title'] = $this->language->get('text_title');
        $data['text_settings'] = $this->language->get('text_settings');

        $data['text_list'] = $this->language->get('text_list');
        $data['text_cities'] = $this->language->get('text_cities');
        $data['text_warehouses'] = $this->language->get('text_warehouses');

        $data['text_updates'] = $this->language->get('text_updates');
        $data['text_success_cities'] = $this->language->get('text_success_cities');
        $data['text_success_warehouses'] = $this->language->get('text_success_warehouses');

        $data['column_key'] = $this->language->get('column_key');

        $data['column_type'] = $this->language->get('column_type');
        $data['column_amount'] = $this->language->get('column_amount');
        $data['column_update'] = $this->language->get('column_update');
        $data['column_action'] = $this->language->get('column_action');

        $data['button_save'] = $this->language->get('button_save');
        $data['button_update_cities'] = $this->language->get('button_update_cities');
        $data['button_update_warehouses'] = $this->language->get('button_update_warehouses');

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text'      => "Главная",
            'href'      => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL'),
        );

        $data['breadcrumbs'][] = array(
            'text'      => $data['heading_title'],
            'href'      => $this->url->link('sale/novaposhta', 'token=' . $this->session->data['token'] , 'SSL'),
        );

        if ( isset($this->request->post['config_novaposhta_key']) ) {
            $data['config_novaposhta_key'] = $this->request->post['config_novaposhta_key'];
        } else {
            $data['config_novaposhta_key'] = $this->config->get('config_novaposhta_key');
        }

        $data['count_cities'] = $this->model_sale_novaposhta->getCountCities();
        $data['count_warehouses'] = $this->model_sale_novaposhta->getCountWarehouses();

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $data['action'] = $this->url->link('sale/novaposhta' , '&token=' . $data['token'], 'SSL');

        $this->response->setOutput($this->load->view('sale/novaposhta.tpl', $data));
    }

    protected function validate() {
        $this->load->language('sale/novaposhta');

        if ((utf8_strlen($this->request->post['config_novaposhta_key']) < 32) || (utf8_strlen($this->request->post['config_novaposhta_key']) > 32)) {
            $this->error['key'] = $this->language->get('error_key');
        }

        return !$this->error;
    }

    public function updateCities() {
        $api_key = $this->config->get('config_novaposhta_key');

        if ( $this->request->server['REQUEST_METHOD'] == 'POST' && $api_key != '' ) {

            $this->load->model('sale/novaposhta');

            $json = array();

            $xml = "<?xml version='1.0' encoding='utf-8'?>
                    <file>
                        <auth>{$api_key}</auth>
                        <modelName>Address</modelName>
                        <calledMethod>getCities</calledMethod>
                    </file>";

            $cities = simplexml_load_string($this->sendRequest($xml));

            $array_cities = array();

            foreach ($cities->data->item as $city) {
                $array_cities[] = array(
                    'Description' => trim($city->Description),
                    'DescriptionRu' => trim($city->DescriptionRu),
                    'Ref' => trim($city->Ref),
                    'Area' => trim($city->Area),
                    'Delivery1' => trim($city->Delivery1),
                    'Delivery2' => trim($city->Delivery2),
                    'Delivery3' => trim($city->Delivery3),
                    'Delivery4' => trim($city->Delivery4),
                    'Delivery5' => trim($city->Delivery5),
                    'Delivery6' => trim($city->Delivery6),
                    'Delivery7' => trim($city->Delivery7),
                    'Conglomerates' => serialize(get_object_vars($city->Conglomerates)),
                    'CityID' => (int)$city->CityID
                );
            }

            $this->model_sale_novaposhta->updateCities($array_cities);

            $json['result'] = count($array_cities);

            $this->response->addHeader('Content-Type: application/json');
            $this->response->setOutput(json_encode($json));

        } else {
            $this->response->redirect($this->url->link('sale/novaposhta', 'token=' . $this->session->data['token'], 'SSL'));
        }
    }

    public function updateWarehouses() {
        $api_key = $this->config->get('config_novaposhta_key');

        if ( $this->request->server['REQUEST_METHOD'] == 'POST' && $api_key != '' ) {

            $this->load->model('sale/novaposhta');

            $json = array();

            $xml = "<?xml version='1.0' encoding='utf-8'?>
                    <file>
                        <auth>{$api_key}</auth>
                        <modelName>Address</modelName>
                        <calledMethod>getWarehouses</calledMethod>
                        <methodProperties></methodProperties>
                    </file>";

            $warehouses = simplexml_load_string($this->sendRequest($xml));

            $array_warehouses = array();

            foreach($warehouses->data->item as $warehouse){
                $array_warehouses[] = array(
                    'SiteKey'           => (int)$warehouse->SiteKey,
                    'Description'       => trim($warehouse->Description),
                    'DescriptionRu'     => trim($warehouse->DescriptionRu),
                    'Phone'             => trim($warehouse->Phone),
                    'TypeOfWarehouse'   => trim($warehouse->TypeOfWarehouse),
                    'Ref'               => trim($warehouse->Ref),
                    'Number'            => (int)$warehouse->Number,
                    'CityRef'           => trim($warehouse->CityRef),
                    'CityDescription'   => trim($warehouse->CityDescription),
                    'CityDescriptionRu' => trim($warehouse->CityDescriptionRu),
                    'Longitude'         => trim($warehouse->Longitude),
                    'Latitude'          => trim($warehouse->Latitude),
                    'PostFinance'       => (int)$warehouse->PostFinance,
                    'BicycleParking'    => (int)$warehouse->BicycleParking,
                    'POSTerminal'       => (int)$warehouse->POSTerminal,
                    'TotalMaxWeightAllowed'   => (int)$warehouse->TotalMaxWeightAllowed,
                    'PlaceMaxWeightAllowed'   => (int)$warehouse->PlaceMaxWeightAllowed,
                    'Reception'         => serialize(get_object_vars($warehouse->Reception)),
                    'Delivery'          => serialize(get_object_vars($warehouse->Delivery)),
                    'Schedule'          => serialize(get_object_vars($warehouse->Schedule))
                );
            }

            $this->model_sale_novaposhta->updateWarehouses($array_warehouses);

            $json['result'] = count($array_warehouses);

            $this->response->addHeader('Content-Type: application/json');
            $this->response->setOutput(json_encode($json));

        } else {
            $this->response->redirect($this->url->link('sale/novaposhta', 'token=' . $this->session->data['token'], 'SSL'));
        }
    }

    private function sendRequest($xml) {
        $ch = curl_init();

        curl_setopt($ch, CURLOPT_URL, 'https://api.novaposhta.ua/v2.0/xml/');
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_HTTPHEADER, Array("Content-Type: text/xml"));
        curl_setopt($ch, CURLOPT_HEADER, 0);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $xml);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);

        $response = curl_exec($ch);

        curl_close($ch);

        return $response;
    }

}