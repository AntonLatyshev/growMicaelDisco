<?php
class ControllerModuleHTML extends Controller {
	public function index($setting) {
		$data['module_id'] = substr($setting['name'], strrpos($setting['name'],"|")+1);

		$data['languagese'] = $this->language->getGroupData();

		if (isset($setting['module_description'][$this->config->get('config_language_id')])) {
			$data['heading_title'] = html_entity_decode($setting['module_description'][$this->config->get('config_language_id')]['title'], ENT_QUOTES, 'UTF-8');
			$data['html'] = html_entity_decode($setting['module_description'][$this->config->get('config_language_id')]['description'], ENT_QUOTES, 'UTF-8');

			if ( empty($setting['module_description'][$this->config->get('config_language_id')]['description_for_html']) ) {
				$data['description_for_html'] = '';
			}

			if ( !empty($setting['module_description'][$this->config->get('config_language_id')]['html_tpl']) ) {
				$data['html_tpl'] = $setting['module_description'][$this->config->get('config_language_id')]['html_tpl'];

				$description_for_html['heading_title'] = html_entity_decode($setting['module_description'][$this->config->get('config_language_id')]['title'], ENT_QUOTES, 'UTF-8');
				$description_for_html['text'] = $data['description_for_html'] = html_entity_decode($setting['module_description'][$this->config->get('config_language_id')]['description_for_html'], ENT_QUOTES, 'UTF-8');
                                
                                $custom_language_id = false;
				$this->load->model('localisation/language');
				$languages = $this->model_localisation_language->getLanguages();
				foreach ( $languages as $key => $value ) {
					if ($key == $this->language->get('code')) {
						$custom_language_id = $value['language_id'];
					}
				}
				$description_for_html['custom_field'] = array();
				if ( !empty($setting['custom_field'][$this->config->get('config_language_id')]) ) {
					$custom_fields = $setting['custom_field'][$this->config->get('config_language_id')];
                                        foreach ($custom_fields as $custom_fields) {
						$description_for_html['custom_field'][$custom_fields['name']] = html_entity_decode($custom_fields['value'], ENT_QUOTES, 'UTF-8');
					}
				}
                                                                
                                if(isset($this->request->get['route'])){
                                    $description_for_html['route'] = true;
                                } else {
                                    $description_for_html['route'] = false;
                                }
                                                                
                                
				$data['html_tpl'] = $this->load->view('default/template/information/html/' . $data['html_tpl'] . '.tpl', $description_for_html);
			} else {
				$data['description_for_html'] = '';
				$data['html_tpl'] = '';
			}

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/html.tpl')) {
				return $this->load->view($this->config->get('config_template') . '/template/module/html.tpl', $data);
			} else {
				return $this->load->view('default/template/module/html.tpl', $data);
			}
		}
	}
}