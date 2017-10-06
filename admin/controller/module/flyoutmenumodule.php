<?php
class ControllerModuleFlyoutmenumodule extends Controller {
	private $error = array(); 
	
	public function index() {   
		$this->language->load('module/flyoutmenumodule');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
		$this->load->model('extension/module');
		$this->load->model('localisation/language');
		
		
		$data['flyoutmenu_menus'] = array();
		$menucount = array();
		
		for ($i=2;$i<=40;$i++) {
			if ($this->config->get('menu'.$i.'_flyoutmenu_menu_id')) {
				$newname = $this->config->get('menu'.$i.'_flyoutmenu_language');
				if (isset($newname['mobilemenuname'][$this->config->get('config_language_id')]) && $newname['mobilemenuname'][$this->config->get('config_language_id')]) {
					$name= $newname['mobilemenuname'][$this->config->get('config_language_id')];
				} else {
					$name = 'Menu ' .$i;
				}
				$data['flyoutmenu_menus'][] =array(
					'id'   => $this->config->get('menu'.$i.'_flyoutmenu_menu_id'),
					'url'  => $this->url->link('module/flyoutmenu', 'token=' . $this->session->data['token'] . '&menu_id=' . $i, 'SSL'),
					'name' => $name
				);
				$menucount[] = $i; 
			}
		}
		if (!$menucount) {
			$allmenus = array();
		} else {
			$allmenus = array(
				'flyoutmenumodule_added_menus' => $menucount
			);
		}
			
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			
			$this->model_setting_setting->editSetting('flyoutmenumodule', $allmenus);	
			
			if (!isset($this->request->get['module_id'])) {
				$this->model_extension_module->addModule('flyoutmenumodule', $this->request->post);
			} else {
				$this->model_extension_module->editModule($this->request->get['module_id'], $this->request->post);
			}
            
            $this->cache->delete('flyoutmenu');
					
			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		
		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['text_tomenu'] = $this->language->get('text_tomenu');
		$data['text_default'] = $this->language->get('text_default');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_no'] = $this->language->get('text_no');
		$data['text_yes'] = $this->language->get('text_yes');
		$data['entry_position'] = $this->language->get('entry_position');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_remove'] = $this->language->get('button_remove');
		$data['text_default_menu'] = $this->language->get('text_default_menu');
		$data['entry_theme'] = $this->language->get('entry_theme');
		$data['entry_menu'] = $this->language->get('entry_menu');
		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_pos'] = $this->language->get('entry_pos');
		$data['text_left'] = $this->language->get('text_left');
		$data['text_right'] = $this->language->get('text_right');
		
		$data['url_tomenu'] = $this->url->link('module/flyoutmenu', 'token=' . $this->session->data['token'], 'SSL');
		
		$data['token'] = $this->session->data['token'];
		
 		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		if (isset($this->error['name'])) {
			$data['error_name'] = $this->error['name'];
		} else {
			$data['error_name'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}
		
  		$data['breadcrumbs'] = array();

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/flyoutmenumodule', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		if (!isset($this->request->get['module_id'])) {
			$data['action'] = $this->url->link('module/flyoutmenumodule', 'token=' . $this->session->data['token'], 'SSL');
		} else {
			$data['action'] = $this->url->link('module/flyoutmenumodule', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL');
		}
		
		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
		}
		
		if (isset($this->request->post['name'])) {
			$data['name'] = $this->request->post['name'];
		} elseif (!empty($module_info)) {
			$data['name'] = $module_info['name'];
		} else {
			$data['name'] = '';
		}
		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($module_info)) {
			$data['status'] = $module_info['status'];
		} else {
			$data['status'] = '';
		}
		if (isset($this->request->post['menu'])) {
			$data['smenu'] = $this->request->post['menu'];
		} elseif (!empty($module_info)) {
			$data['smenu'] = $module_info['menu'];
		} else {
			$data['smenu'] = '';
		}
		if (isset($this->request->post['theme'])) {
			$data['theme'] = $this->request->post['theme'];
		} elseif (!empty($module_info)) {
			$data['theme'] = $module_info['theme'];
		} else {
			$data['theme'] = '';
		}
		if (isset($this->request->post['position'])) {
			$data['position'] = $this->request->post['position'];
		} elseif (!empty($module_info)) {
			$data['position'] = $module_info['position'];
		} else {
			$data['position'] = '';
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/flyoutmenumodule.tpl', $data));
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/flyoutmenumodule')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 64)) {
			$this->error['name'] = $this->language->get('error_name');
		}

		return !$this->error;	
	}
}
?>