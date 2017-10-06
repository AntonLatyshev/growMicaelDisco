<?php
class ControllerToolSeoTitles extends Controller {
    private $error = array();

    public function index() {
        $this->load->language('tool/seo_titles');

        $this->document->setTitle($this->language->get('heading_title'));

        $data['heading_title'] = 'SEO Titles';

        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        if (isset($this->session->data['success'])) {
            $data['success'] = $this->session->data['success'];

            unset($this->session->data['success']);
        } else {
            $data['success'] = '';
        }

        if (isset($this->request->post['seo_module_url'])) {
            $data['seo_module_url'] = $this->request->post['seo_module_url'];
        } else {
            $data['seo_module_url'] = '';
        }

        if (isset($this->request->post['seo_module_title'])) {
            $data['seo_module_title'] = $this->request->post['seo_module_title'];
        } else {
            $data['seo_module_title'] = '';
        }

        if (isset($this->request->post['seo_module_desc'])) {
            $data['seo_module_desc'] = $this->request->post['seo_module_desc'];
        } else {
            $data['seo_module_desc'] = '';
        }

        if (isset($this->request->post['seo_module_keyword'])) {
            $data['seo_module_keyword'] = $this->request->post['seo_module_keyword'];
        } else {
            $data['seo_module_keyword'] = '';
        }

        if (isset($this->request->post['seo_module_h1'])) {
            $data['seo_module_h1'] = $this->request->post['seo_module_h1'];
        } else {
            $data['seo_module_h1'] = '';
        }

        if (isset($this->request->post['seo_module_text'])) {
            $data['seo_module_text'] = $this->request->post['seo_module_text'];
        } else {
            $data['seo_module_text'] = '';
        }

        $data['text_add'] = $this->language->get('text_add');
        $data['text_list'] = $this->language->get('text_list');
        $data['text_confirm'] = $this->language->get('text_confirm');
        $data['text_no_results'] = $this->language->get('text_no_results');

        $data['entry_filter'] = $this->language->get('entry_filter');

        $data['button_add'] = $this->language->get('button_add');
        $data['button_clear'] = $this->language->get('button_clear');
        $data['button_filter'] = $this->language->get('button_filter');

        $data['column_h1'] = $this->language->get('column_h1');
        $data['column_url'] = $this->language->get('column_url');
        $data['column_name'] = $this->language->get('column_name');
        $data['column_action'] = $this->language->get('column_action');
        $data['column_description'] = $this->language->get('column_description');

        $data['error_url'] = $this->language->get('error_url');

        $data['error_text_success'] = $this->language->get('error_text_success');
        $data['error_text_warning'] = $this->language->get('error_text_warning');
        $data['error_text_permission'] = $this->language->get('error_text_permission');

        $data['breadcrumbs'] = array();

        $data['token'] = $this->session->data['token'];

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('tool/seo_titles', 'token=' . $this->session->data['token'], 'SSL')
        );

        if (isset($this->request->get['filter_name'])) {
            $filter_name = $this->request->get['filter_name'];
            $data['filter_name'] = $this->request->get['filter_name'];
        } else {
            $filter_name = false;
            $data['filter_name'] = false;
        }

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }

        $filter_data = array(
            'filter_name' => $filter_name,
            'start'           => ($page - 1) * 10,
            'limit'           => 10
        );

        $url = '';

        if (isset($this->request->get['filter_name'])) {
            $url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
        }

        if (isset($this->request->get['page'])) {
            $url .= '&page=' . $this->request->get['page'];
        }

        $data['action'] = $this->url->link('tool/seo_titles/add', 'token=' . $this->session->data['token'] . $url, 'SSL');

        $data['all_data'] = $this->getAllData($filter_data);

        $total_links_count = $this->allDataCount();

        $pagination = new Pagination();
        $pagination->total = $total_links_count['total'];
        $pagination->page = $page;
        $pagination->limit = 10;
        $pagination->url = $this->url->link('tool/seo_titles', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

        $data['pagination'] = $pagination->render();
        $data['results'] = sprintf($this->language->get('text_pagination'), ($total_links_count['total']) ? (($page - 1) * 10) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($total_links_count['total'] - 10)) ? $total_links_count['total'] : ((($page - 1) * 10) + 10), $total_links_count['total'], ceil($total_links_count['total'] / 10));

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('tool/seo_titles.tpl', $data));
    }

    public function add() {

        if ( ($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm() ) {

            $this->db->query("INSERT INTO oc_seo_mobule_link SET 
              seo_url = '". $this->db->escape($this->request->post['seo_module_url']) ."', 
              seo_h1 = '" . $this->db->escape($this->request->post['seo_module_h1']) . "', 
              seo_text = '" . $this->db->escape($this->request->post['seo_module_text']) . "',
              seo_title = '" . $this->db->escape($this->request->post['seo_module_title']) . "',
              seo_desc = '" . $this->db->escape($this->request->post['seo_module_desc']) . "', 
              seo_keyword = '" . $this->db->escape($this->request->post['seo_module_keyword']) . "'");

            $this->response->redirect($this->url->link('tool/seo_titles', 'token=' . $this->session->data['token'], 'SSL'));
        }

        $this->index();
    }

    public function edit() {

        $seo_id = (int)$this->request->post['seo_id'];

        if ( !empty($seo_id) ) {

            $this->load->model('localisation/language');

            $data = array(
                'languages'     => $this->model_localisation_language->getLanguages(),
                'token'         => $this->session->data['token']
            );

            $query = $this->db->query("SELECT * FROM oc_seo_mobule_link WHERE seo_mobule_link = '" . $seo_id . "'");

            if ($query->num_rows) {

                $result = $query->row;

                $data['seo_id'] = $seo_id;
                $data['seo_url'] = $result['seo_url'];
                $data['seo_title'] = $result['seo_title'];
                $data['seo_desc'] = $result['seo_desc'];
                $data['seo_keyword'] = $result['seo_keyword'];

                $data['seo_h1'] = $result['seo_h1'];
                $data['seo_text'] = $result['seo_text'];

                if ($seo_id) {
                    $data['seo_description'] = $this->getSeoDescriptions($seo_id);
                } else {
                    $data['seo_description'] = array();
                }

            } else {
                $data['seo_id'] = '';
                $data['seo_url'] = '';
                $data['seo_title'] = '';
                $data['seo_desc'] = '';
                $data['seo_keyword'] = '';

                $data['seo_h1'] = '';
                $data['seo_text'] = '';
            }

            if (!empty($seo_id)) {
                $data['action'] = $this->url->link('tool/seo_titles/refresher', '', 'SSL');
            } else {
                $data['action'] = '';
            }

            return $this->response->setOutput($this->load->view('tool/seo_edit.tpl', $data));

        } else {
            return false;
        }

    }

    public function getAllData($filter_data) {

        $query = "SELECT * FROM oc_seo_mobule_link";

        if ($filter_data['filter_name']) {
            $query .= " WHERE seo_url LIKE '".'%' . $filter_data['filter_name'] . '%'."'";
        }

        if (isset($filter_data['start']) || isset($filter_data['limit'])) {
            if ($filter_data['start'] < 0) {
                $filter_data['start'] = 0;
            }

            if ($filter_data['limit'] < 1) {
                $filter_data['limit'] = 20;
            }

            $query .= " LIMIT " . (int)$filter_data['start'] . "," . (int)$filter_data['limit'];
        }

        $query_ = $this->db->query($query);

        if ($query_->num_rows) {
            return $query_->rows;
        } else {
            return false;
        }
    }

    public function refresher() {

        $json = array();

        $seo_id = (int)$this->request->get['seo_id'];

        if ( $this->request->server['REQUEST_METHOD'] == 'POST' && $this->validateFormRefresher() ){
            $this->db->query("UPDATE " . DB_PREFIX . "seo_mobule_link SET 
                seo_url = '" . $this->db->escape($this->request->post['seo_url']) . "', 
				seo_title = '" . $this->db->escape($this->request->post['seo_title']) . "', 
				seo_h1 = '" . $this->db->escape($this->request->post['seo_h1']) . "', 
				seo_desc = '" . $this->db->escape($this->request->post['seo_desc']) . "', 
				seo_keyword = '" . $this->db->escape($this->request->post['seo_keyword']) . "', 
				seo_text = '" . $this->db->escape($this->request->post['seo_text']) . "'
			WHERE 
			    seo_mobule_link = '" . $seo_id . "'");

            $json['success'] = true;
        }

        if ( isset($this->error) ) {
            $json['error'] = $this->error;
        } else {
            $json['error'] = false;
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));

    }

    public function deleter()
    {
        if ($this->request->server['REQUEST_METHOD'] == 'POST'){
            $this->db->query("DELETE FROM " . DB_PREFIX . "seo_mobule_link WHERE seo_mobule_link = '" . (int)$this->request->post['seo_id'] . "'");
        }
    }

    public function allDataCount()
    {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM oc_seo_mobule_link");
        if($query->num_rows){
            return $query->row;
        }else{
            return false;
        }
    }

    protected function validateForm() {
        $this->load->language('tool/seo_titles');

        if (!$this->user->hasPermission('modify', 'tool/seo_titles')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if ( (utf8_strlen($this->request->post['seo_module_h1']) < 2) || (utf8_strlen($this->request->post['seo_module_h1']) > 255) ) {
            $this->error['warning'] = $this->language->get('error_h1');
        }

        if ( (utf8_strlen($this->request->post['seo_module_url']) < 2) || (utf8_strlen($this->request->post['seo_module_url']) > 255) ) {
            $this->error['warning'] = $this->language->get('error_url');
        }

        if ( (utf8_strlen($this->request->post['seo_module_title']) < 2) || (utf8_strlen($this->request->post['seo_module_title']) > 255) ) {
            $this->error['warning'] = $this->language->get('error_title');
        }

        if ( (utf8_strlen($this->request->post['seo_module_desc']) < 3) || (utf8_strlen($this->request->post['seo_module_desc']) > 255) ) {
            $this->error['warning'] = $this->language->get('error_meta_title');
        }

        if ( (utf8_strlen($this->request->post['seo_module_keyword']) < 3) || (utf8_strlen($this->request->post['seo_module_keyword']) > 255) ) {
            $this->error['warning'] = $this->language->get('error_meta_keyword');
        }

        if ( utf8_strlen($this->request->post['seo_module_text']) < 30 ) {
            $this->error['warning'] = $this->language->get('error_text');
        }

        return !$this->error;
    }

    protected function validateFormRefresher() {
        $this->load->language('tool/seo_titles');

        if (!$this->user->hasPermission('modify', 'tool/seo_titles')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if ( (utf8_strlen($this->request->post['seo_h1']) < 2) || (utf8_strlen($this->request->post['seo_h1']) > 255) ) {
            $this->error['seo_h1'] = $this->language->get('error_h1');
        }

        if ( (utf8_strlen($this->request->post['seo_url']) < 2) || (utf8_strlen($this->request->post['seo_url']) > 255) ) {
            $this->error['seo_url'] = $this->language->get('error_url');
        }

        if ( (utf8_strlen($this->request->post['seo_title']) < 2) || (utf8_strlen($this->request->post['seo_title']) > 255) ) {
            $this->error['seo_title'] = $this->language->get('error_title');
        }

        if ( (utf8_strlen($this->request->post['seo_desc']) < 3) || (utf8_strlen($this->request->post['seo_desc']) > 255) ) {
            $this->error['seo_desc'] = $this->language->get('error_meta_title');
        }

        if ( (utf8_strlen($this->request->post['seo_keyword']) < 3) || (utf8_strlen($this->request->post['seo_keyword']) > 255) ) {
            $this->error['seo_keyword'] = $this->language->get('error_meta_keyword');
        }

        if ( utf8_strlen($this->request->post['seo_text']) < 30 ) {
            $this->error['seo_text'] = $this->language->get('error_text');
        }

        return !$this->error;
    }

    // Model
    private function getSeoDescriptions($seo_mobule_link) {
        $seo_data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "seo_mobule_description WHERE seo_mobule_link = '" . (int)$seo_mobule_link . "'");

        foreach ($query->rows as $result) {
            $seo_data[$result['language_id']] = array(
                'meta_title'        => $result['meta_title'],
                'meta_description'  => $result['meta_description'],
                'meta_keyword'      => $result['meta_keyword'],
                'h1'                => $result['h1'],
                'text'              => $result['text']
            );
        }

        return $seo_data;
    }

}