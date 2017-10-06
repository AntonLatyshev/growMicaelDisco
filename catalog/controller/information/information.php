<?php
class ControllerInformationInformation extends Controller {
	public function index() {
		$this->load->language('information/information');

		$this->load->model('catalog/information');

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		if (isset($this->request->get['information_id'])) {
			$information_id = (int)$this->request->get['information_id'];
		} else {
			$information_id = 0;
		}

		$temp_inf = "information_id=" . $information_id;
		$seo_url = $this->db->query("SELECT keyword FROM oc_url_alias WHERE query = '" . $temp_inf . "'");

		if($seo_url->num_rows){
			if($this->session->data['language'] != 'ru'){
				$true_seo_url = "/" . $this->session->data['language']. "/" .$seo_url->row['keyword'];
			}else{
				$true_seo_url = "/" . $seo_url->row['keyword'];
			}
		}else{
			$true_seo_url = "";
		}





		$parst_of_url = $_SERVER['REQUEST_URI'];


		if($true_seo_url !=  $parst_of_url){
			$this->response->redirect($true_seo_url);
		}

		$information_info = $this->model_catalog_information->getInformation($information_id);

		if ($information_info) {
			$this->document->setTitle($information_info['meta_title']);
			$this->document->setDescription($information_info['meta_description']);
			$this->document->setKeywords($information_info['meta_keyword']);

			$data['breadcrumbs'][] = array(
				'text' => $information_info['title'],
				'href' => $this->url->link('information/information', 'information_id=' .  $information_id)
			);

			$data['heading_title'] = $information_info['title'];

			// Start custom_fields
			$custom_language_id = false;

			$this->load->model('localisation/language');

			$languages = $this->model_localisation_language->getLanguages();
			foreach ( $languages as $key => $value ) {
				if ($key == $this->language->get('code')) {
					$custom_language_id = $value['language_id'];
				}
			}

			$data['custom_field'] = array();
			if ( !empty($information_info['custom_field']) ) {
				$custom_fields = json_decode($information_info['custom_field'], true);
				if ( !empty($custom_fields[$custom_language_id]) ) {
					foreach ($custom_fields[$custom_language_id] as $custom_fields) {
						$data['custom_field'][$custom_fields['name']] = $custom_fields['value'];
					}
				}
			}

			// var_dump($data['custom_field']);
			// End custom_fields

			$data['button_continue'] = $this->language->get('button_continue');

			$data['description'] = html_entity_decode($information_info['description'], ENT_QUOTES, 'UTF-8');

			$data['continue'] = $this->url->link('common/home');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			/* layout patch - choose template by path */
			$this->load->model ( 'design/layout' );
			if (isset ( $this->request->get ['route'] )) {
				$route = ( string ) $this->request->get ['route'];
			} else {
				$route = 'common/home';
			}
			$layout_template = $this->model_design_layout->getLayoutTemplate($route);
			$isLayoutRoute = true;
			if(!$layout_template){
				$layout_template = 'information';
				$isLayoutRoute = false;
			}
			// get general layout template
			if(!$isLayoutRoute){
				$layout_id = $this->model_catalog_information->getInformationLayoutId($information_id);
				if($layout_id){
					$tmp_layout_template = $this->model_design_layout->getGeneralLayoutTemplate($layout_id);
					if($tmp_layout_template)
						$layout_template = $tmp_layout_template;
				}
			}

			$data['languagese'] = $this->language->getGroupData();

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/' . $layout_template . '.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/information/' . $layout_template . '.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('default/template/information/' . $layout_template . '.tpl', $data));
			}
		} else {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('information/information', 'information_id=' . $information_id)
			);

			$this->document->setTitle($this->language->get('text_error'));

			$data['heading_title'] = $this->language->get('text_error');

			$data['text_error'] = $this->language->get('text_error');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/error/not_found.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('default/template/error/not_found.tpl', $data));
			}
		}
	}

	public function agree() {
		$this->load->model('catalog/information');

		if (isset($this->request->get['information_id'])) {
			$information_id = (int)$this->request->get['information_id'];
		} else {
			$information_id = 0;
		}

		$output = '';

		$information_info = $this->model_catalog_information->getInformation($information_id);

		if ($information_info) {
			$output .= html_entity_decode($information_info['description'], ENT_QUOTES, 'UTF-8') . "\n";
		}

		$this->response->setOutput($output);
	}
}