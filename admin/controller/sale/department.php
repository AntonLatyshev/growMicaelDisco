<?php
class ControllerSaleDepartment extends Controller {
    public function index() {

        $this->load->language('sale/department');

        $data = array();
        $data['heading_title'] = $this->language->get('heading_title');
        $this->document->setTitle($data['heading_title']);
        $data['token'] = $this->session->data['token'];
        $data['action'] = $this->url->link('sale/department/addDepartment' , '&token=' . $data['token'], 'SSL');
        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text'      => "Главная",
            'href'      => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL'),
        );

        $data['breadcrumbs'][] = array(
            'text'      => $data['heading_title'],
            'href'      => $this->url->link('sale/department', 'token=' . $this->session->data['token'] , 'SSL'),
        );

        $filter_array['country_id'] = $this->config->get('config_country_id');
        $data['zones'] = $this->getZones($filter_array);
        $data['current_zone'] = $this->config->get('config_zone_id');

        $data['warenhouses'] = $this->getStockWarenhous();

        $data['button_add'] = $this->language->get('button_add');
        $data['button_delete'] = $this->language->get('button_delete');

        $data['text_none'] = $this->language->get('text_none');
        $data['text_zone'] = $this->language->get('text_zone');
        $data['text_city'] = $this->language->get('text_city');
        $data['text_address'] = $this->language->get('text_address');
        $data['text_phone'] = $this->language->get('text_phone');
        $data['text_confirm'] = $this->language->get('text_confirm');
        $data['text_no_results'] = $this->language->get('text_no_results');

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('sale/department.tpl', $data));
    }

    public function getZones($data = array()) {
        $sql = "SELECT * FROM `" . DB_PREFIX . "zone`";

        if (!empty($data['country_id'])) {
            $sql .= " WHERE status = '1' AND country_id = '" . (int)$data['country_id'] . "'";

            if (!empty($data['filter_name'])) {
                $sql .= " AND name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
            }

            $sort_data = array(
                'name',
                'sort_order'
            );

            if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
                $sql .= " ORDER BY " . $data['sort'];
            } else {
                $sql .= " ORDER BY name";
            }

            if (isset($data['order']) && ($data['order'] == 'DESC')) {
                $sql .= " DESC";
            } else {
                $sql .= " ASC";
            }

            if (isset($data['start']) || isset($data['limit'])) {
                if ($data['start'] < 0) {
                    $data['start'] = 0;
                }

                if ($data['limit'] < 1) {
                    $data['limit'] = 25;
                }

                $sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
            }

            $query = $this->db->query($sql);

            return $query->rows;
        } else {
            return false;
        }
    }

    public function getCityByZone()
    {
        $filter_data = array();

        if(!empty($this->request->post['zone_ref'])){
            $filter_data['zone_ref'] = $this->request->post['zone_ref'];
        }

        $citys['cities'] = $this->getCities($filter_data);

        if($citys){
            $this->response->addHeader('Content-Type: application/json');
            $this->response->setOutput(json_encode($citys));
        }else{
            return false;
        }
    }

    public function getCities($data = array()) {

        $sql = "SELECT *, DescriptionRu as name, Ref as ref FROM `" . DB_PREFIX . "cities`";

        if (!empty($data['zone_ref'])) {
            $sql .= " WHERE Area = '" . $data['zone_ref'] . "'";


            if (!empty($data['filter_name'])) {
                $sql .= " AND name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
            }


            $sort_data = array(
                'name'
            );

            if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
                $sql .= " ORDER BY " . $data['sort'];
            } else {
                $sql .= " ORDER BY name";
            }

            if (isset($data['order']) && ($data['order'] == 'DESC')) {
                $sql .= " DESC";
            } else {
                $sql .= " ASC";
            }

            if (isset($data['start']) || isset($data['limit'])) {
                if ($data['start'] < 0) {
                    $data['start'] = 0;
                }

                if ($data['limit'] < 1) {
                    $data['limit'] = 25;
                }

                $sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
            }

            $query = $this->db->query($sql);

            return $query->rows;
        } else {
            return false;
        }
    }

    public function addDepartment()
    {
        if($this->request->post){
            $this->db->query("INSERT INTO `" . DB_PREFIX . "store_warehouse` SET `DescriptionRu` = '" . $this->db->escape($this->request->post['address']) . "', `CityDescriptionRu` = '" . $this->db->escape($this->request->post['city']) . "', `Phone` = '" .  $this->db->escape($this->request->post['phone']) . "', `CityRef` = '" .  $this->db->escape($this->request->post['city_id']) . "'");
            $this->response->redirect($this->url->link('sale/department', 'token=' . $this->session->data['token']));
        }
    }

    public function getStockWarenhous()
    {
        $data = $this->db->query('SELECT * FROM oc_store_warehouse');
        if($data->num_rows){
            return $data->rows;
        }else{
            return false;
        }
    }

    public function delete_wh()
    {
       if($this->request->post['war_id']){
           $this->db->query("DELETE FROM oc_store_warehouse WHERE id= '" . (int)$this->request->post['war_id'] . "'");
       }
    }
}