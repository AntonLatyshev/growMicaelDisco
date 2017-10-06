<?php
class ControllerModuleFlyoutmenu extends Controller {
	private $error = array(); 
	
	public function index() {   
		$this->language->load('module/flyoutmenu');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
		$this->load->model('catalog/category');
		$this->load->model('catalog/information');
		$this->load->model('localisation/language');
		$this->load->model('tool/image');
        $this->load->model('setting/store');
		
		if (isset($this->request->get['menu_id']) && (int)$this->request->get['menu_id']) {
			$preffix = 'menu'.(int)$this->request->get['menu_id'].'_';
			$data['current_menu'] = (int)$this->request->get['menu_id'];
		} else {
			$preffix = '';	
			$data['current_menu'] = 0;
		}
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			if (!$preffix) {
				$this->model_setting_setting->editSetting('flyoutmenu', $this->request->post);	
			} else {
				$this->model_setting_setting->editSetting($preffix.'flyoutmenu', $this->request->post);	
			}
			
            $this->cache->delete('flyoutmenu');
					
			$this->session->data['success'] = $this->language->get('text_success');
			if (!$preffix) {		
				$this->response->redirect($this->url->link('module/flyoutmenu', 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->response->redirect($this->url->link('module/flyoutmenu', 'token=' . $this->session->data['token'] . '&menu_id=' . $data['current_menu'], 'SSL'));
			}
		}
		
		$data['preffix'] = $preffix;
		
		$data['active_language'] = $this->config->get('config_language_id');
		
		$data['flyoutmenu_menus'] = array();
		
		if (!$preffix) {
			$data['delete_url'] = false;
		} else {
			$data['delete_url'] = $this->url->link('module/flyoutmenu/delete', 'token=' . $this->session->data['token'] . '&menu_id=' . $data['current_menu'], 'SSL');
		}
		
		$latest_menu = 1;
		
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
				$latest_menu = $i;
			}
		}
		$data['newmenu'] = $latest_menu + 1;
		
			
		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['stores'] = $this->model_setting_store->getStores();
		$data['text_tomodule'] = $this->language->get('text_tomodule');
		$data['text_stores'] = $this->language->get('text_stores');
		$data['text_fbrands'] = $this->language->get('text_fbrands');
		$data['text_default'] = $this->language->get('text_default');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_content_top'] = $this->language->get('text_content_top');
		$data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$data['text_column_left'] = $this->language->get('text_column_left');
		$data['text_column_right'] = $this->language->get('text_column_right');
		$data['text_image'] = $this->language->get('text_image');
		$data['text_expando'] = $this->language->get('text_expando');
		$data['text_sorder'] = $this->language->get('text_sorder');
		$data['text_tlcolor'] = $this->language->get('text_tlcolor');
		$data['text_tlstyle'] = $this->language->get('text_tlstyle');
		$data['text_justadd'] = $this->language->get('text_justadd');
		$data['text_alldrop'] = $this->language->get('text_alldrop');
		$data['text_overdrop'] = $this->language->get('text_overdrop');
		$data['text_flyoutmenuisresponsive'] = $this->language->get('text_flyoutmenuisresponsive');
		$data['text_or'] = $this->language->get('text_or');
		$data['text_no'] = $this->language->get('text_no');
		$data['tab_items'] = $this->language->get('tab_items');
		$data['tab_mods'] = $this->language->get('tab_mods');
		$data['tab_settings'] = $this->language->get('tab_settings');
		$data['tab_html'] = $this->language->get('tab_html');
		$data['text_yes'] = $this->language->get('text_yes');
		$data['text_browse'] = $this->language->get('text_browse');
		$data['text_clear'] = $this->language->get('text_clear');
		$data['text_image_manager'] = $this->language->get('text_image_manager');
		$data['text_unselect_all'] = $this->language->get('text_unselect_all');
		$data['text_select_all'] = $this->language->get('text_select_all');
		$data['entry_layout'] = $this->language->get('entry_layout');
		$data['entry_add'] = $this->language->get('entry_add');
		$data['text_slist'] = $this->language->get('text_slist');
		$data['text_sgrid'] = $this->language->get('text_sgrid');
		$data['text_sview'] = $this->language->get('text_sview');
		$data['text_dwidth'] = $this->language->get('text_dwidth');
		$data['text_iwidth'] = $this->language->get('text_iwidth');
		$data['text_chtml'] = $this->language->get('text_chtml');
		$data['text_cchtml'] = $this->language->get('text_cchtml');
		$data['text_whatproducts'] = $this->language->get('text_whatproducts');
		$data['text_productlatest'] = $this->language->get('text_productlatest');
		$data['text_productspecial'] = $this->language->get('text_productspecial');
		$data['text_productfeatured'] = $this->language->get('text_productfeatured');
		$data['text_productbestseller'] = $this->language->get('text_productbestseller');
		$data['text_productlimit'] = $this->language->get('text_productlimit');
		$data['entry_type'] = $this->language->get('entry_type');
		$data['entry_category'] = $this->language->get('entry_category');
		$data['entry_custom'] = $this->language->get('entry_custom');
		$data['entry_information'] = $this->language->get('entry_information');
		$data['entry_advanced'] = $this->language->get('entry_advanced');
		$data['custom_name'] = $this->language->get('custom_name');
		$data['custom_url'] = $this->language->get('custom_url');
		$data['type_cat'] = $this->language->get('type_cat');
		$data['type_mand'] = $this->language->get('type_mand');
		$data['type_infol'] = $this->language->get('type_infol');
		$data['type_products'] = $this->language->get('type_products');
		$data['type_catprods'] = $this->language->get('type_catprods');
		$data['type_infod'] = $this->language->get('type_infod');
		$data['entry_iset'] = $this->language->get('entry_iset');
		$data['type_custom'] = $this->language->get('type_custom');
		$data['type_more'] = $this->language->get('type_more');
		$data['type_more2'] = $this->language->get('type_more2');
		$data['type_login'] = $this->language->get('type_login');
		$data['entry_position'] = $this->language->get('entry_position');
		$data['entry_count'] = $this->language->get('entry_count');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_add_module'] = $this->language->get('button_add_module');
		$data['button_add_item'] = $this->language->get('button_add_item');
		$data['button_remove'] = $this->language->get('button_remove');
		$data['more_name'] = $this->language->get('more_name');
		$data['more2_name'] = $this->language->get('more2_name');
		$data['more_status'] = $this->language->get('more_status');
		$data['entry_image_size'] = $this->language->get('entry_image_size');
		$data['entry_show_description'] = $this->language->get('entry_show_description');
		$data['text_general'] = $this->language->get('text_general');
		$data['text_more_dropdown'] = $this->language->get('text_more_dropdown');
		$data['text_more2_dropdown'] = $this->language->get('text_more2_dropdown');
		$data['text_languagerelated'] = $this->language->get('text_languagerelated');
		$data['text_customization'] = $this->language->get('text_customization');
		$data['text_settings_isresponsive'] = $this->language->get('text_settings_isresponsive');
		$data['text_settings_dropdowntitle'] = $this->language->get('text_settings_dropdowntitle');
		$data['text_settings_topitemlink'] = $this->language->get('text_settings_topitemlink');
		$data['text_settings_flyoutwidth'] = $this->language->get('text_settings_flyoutwidth');
		$data['text_settings_bspacewidth'] = $this->language->get('text_settings_bspacewidth');
		$data['text_settings_mobilemenuname'] = $this->language->get('text_settings_mobilemenuname');
		$data['text_settings_infodname'] = $this->language->get('text_settings_infodname');
		$data['text_settings_brandsdname'] = $this->language->get('text_settings_brandsdname');
		$data['text_settings_latestpname'] = $this->language->get('text_settings_latestpname');
		$data['text_settings_specialpname'] = $this->language->get('text_settings_specialpname');
		$data['text_settings_featuredpname'] = $this->language->get('text_settings_featuredpname');
		$data['text_settings_bestpname'] = $this->language->get('text_settings_bestpname');
		$data['text_subcatdisplay'] = $this->language->get('text_subcatdisplay');
		$data['text_subcatdisplay_all'] = $this->language->get('text_subcatdisplay_all');
		$data['text_subcatdisplay_level1'] = $this->language->get('text_subcatdisplay_level1');
		$data['text_subcatdisplay_none'] = $this->language->get('text_subcatdisplay_none');
		$data['text_3dlevellimit'] = $this->language->get('text_3dlevellimit');
		$data['text_settings_viewallname'] = $this->language->get('text_settings_viewallname');
		$data['text_settings_viewmorename'] = $this->language->get('text_settings_viewmorename');
		$data['text_settings_dropeffect'] = $this->language->get('text_settings_dropeffect');
		$data['text_settings_hoverintent'] = $this->language->get('text_settings_hoverintent');
		$data['text_settings_tophomelink'] = $this->language->get('text_settings_tophomelink');
		$data['text_settings_menuskin'] = $this->language->get('text_settings_menuskin');
		$data['text_settings_flyoutcache'] = $this->language->get('text_settings_flyoutcache');
		$data['text_editting_menu'] = $this->language->get('text_editting_menu');
		$data['text_new_menu'] = $this->language->get('text_new_menu');
		$data['text_selectedit_menu'] = $this->language->get('text_selectedit_menu');
		$data['text_default_menu'] = $this->language->get('text_default_menu');
		$data['text_delete_menu'] = $this->language->get('text_delete_menu');
		$data['text_delete_confirm'] = $this->language->get('text_delete_confirm');
		$data['text_dflist'] = $this->language->get('text_dflist');
		$data['text_dfgrid'] = $this->language->get('text_dfgrid');
		$data['entry_theme'] = $this->language->get('entry_theme');
		$data['text_flyout_position'] = $this->language->get('text_flyout_position');
		$data['text_flyout_position_ul'] = $this->language->get('text_flyout_position_ul');
		$data['text_flyout_position_li'] = $this->language->get('text_flyout_position_li');
		$data['text_settings_fproduct'] = $this->language->get('text_settings_fproduct');
		
		$data['url_tomodule'] = $this->url->link('module/flyoutmenumodule', 'token=' . $this->session->data['token'], 'SSL');
		
		$data['token'] = $this->session->data['token'];
		
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
			'href'      => $this->url->link('module/flyoutmenu', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		$data['default_url'] = $this->url->link('module/flyoutmenu', 'token=' . $this->session->data['token'], 'SSL');
		if (!$data['current_menu']) {
			$data['action'] = $this->url->link('module/flyoutmenu', 'token=' . $this->session->data['token'], 'SSL');
		} else {
			$data['action'] = $this->url->link('module/flyoutmenu', 'token=' . $this->session->data['token'] . '&menu_id=' . $data['current_menu'], 'SSL');
		}
		
		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		$data['no_image'] = $this->model_tool_image->resize('no_image.png', 100, 100);
		$data['modules'] = array();
		$data['items'] = array();
		$data['categories'] = array();
		$data['informations'] = array();
		$data['languages'] = $this->model_localisation_language->getLanguages();
		$filter_data = array(
			'sort'  => 'name',
			'order' => 'ASC'
		);
		$categ = $this->model_catalog_category->getCategories($filter_data);

		foreach ($categ as $cate) {
							
			$data['categories'][] = array(
				'category_id' => $cate['category_id'],
				'name'        => $cate['name']
			);
		}
		
		$infos = $this->model_catalog_information->getInformations();
		
		foreach ($infos as $info) {
							
			$data['informations'][] = array(
				'information_id' => $info['information_id'],
				'name'           => $info['title']
			);
		}
		
		
		if (isset($this->request->post['flyoutmenu_module'])) {
			$data['modules'] = $this->request->post['flyoutmenu_module'];
		} elseif ($this->config->get('flyoutmenu_module')) { 
			$data['modules'] = $this->config->get('flyoutmenu_module');
		}
		if (isset($this->request->post[$preffix.'flyoutmenu_item'])) {
			$data['items'] = $this->request->post[$preffix.'flyoutmenu_item'];
		} elseif ($this->config->get($preffix.'flyoutmenu_item')) { 
			$data['items'] = $this->config->get($preffix.'flyoutmenu_item');
		} else {
			$data['items'] = array();
		}
		if (isset($this->request->post[$preffix.'flyoutmenu_settings'])) {
			$data['settings'] = $this->request->post[$preffix.'flyoutmenu_settings'];
		} elseif ($this->config->get($preffix.'flyoutmenu_settings')) { 
			$data['settings'] = $this->config->get($preffix.'flyoutmenu_settings');
		} else {
			$data['settings'] = array();
		}
		if (isset($this->request->post[$preffix.'flyoutmenu_settings_status'])) {
			$data['flyoutmenu_settings_status'] = $this->request->post[$preffix.'flyoutmenu_settings_status'];
		} elseif ($this->config->get($preffix.'flyoutmenu_settings_status')) { 
			$data['flyoutmenu_settings_status'] = $this->config->get($preffix.'flyoutmenu_settings_status');
		} else {
		    $data['flyoutmenu_settings_status'] = '';
		}
		if (isset($this->request->post[$preffix.'flyoutmenu_more'])) {
			$data['flyoutmenu_more'] = $this->request->post[$preffix.'flyoutmenu_more'];
		} elseif ($this->config->get($preffix.'flyoutmenu_more')) {
			$data['flyoutmenu_more'] = $this->config->get($preffix.'flyoutmenu_more');
		} else {
			$data['flyoutmenu_more'] = array();
		}
		if (isset($this->request->post[$preffix.'flyoutmenu_more2'])) {
			$data['flyoutmenu_more2'] = $this->request->post[$preffix.'flyoutmenu_more2'];
		} elseif ($this->config->get($preffix.'flyoutmenu_more2')) {
			$data['flyoutmenu_more2'] = $this->config->get($preffix.'flyoutmenu_more2');
		} else {
			$data['flyoutmenu_more2'] = array();
		}
		
        if (isset($this->request->post[$preffix.'flyoutmenu_options'])) {
            $fo = $this->request->post[$preffix.'flyoutmenu_options'];
        } elseif ($this->config->get($preffix.'flyoutmenu_options')) {
            $fo = $this->config->get($preffix.'flyoutmenu_options');
        } else {
            $fo = array();
        }
		if (isset($fo['dropdowntitle'])) {
			$data['flyoutmenu_dropdowntitle'] = $fo['dropdowntitle'];
		} else {
		    $data['flyoutmenu_dropdowntitle'] = 0;
		}
		if (isset($fo['positioning'])) {
			$data['flyoutmenu_positioning'] = $fo['positioning'];
		} else {
		    $data['flyoutmenu_positioning'] = 1;
		}
		if (isset($fo['topitemlink'])) {
			$data['flyoutmenu_topitemlink'] = $fo['topitemlink'];
		} else {
		    $data['flyoutmenu_topitemlink'] = 'topitem';
		}
		if (isset($fo['flyout_width'])) {
			$data['flyoutmenu_flyout_width'] = $fo['flyout_width'];
		} else {
		    $data['flyoutmenu_flyout_width'] = 880;
		}
		if (isset($fo['flyoutcache'])) {
			$data['flyoutmenu_flyoutcache'] = $fo['flyoutcache'];
		} else {
		    $data['flyoutmenu_flyoutcache'] = 0;
		}
		if (isset($fo['bannerspace_width'])) {
			$data['flyoutmenu_bannerspace_width'] = $fo['bannerspace_width'];
		} else {
		    $data['flyoutmenu_bannerspace_width'] = '';
		}
		if (isset($fo['3dlevellimit'])) {
			$data['flyoutmenu_3dlevellimit'] = $fo['3dlevellimit'];
		} else {
		    $data['flyoutmenu_3dlevellimit'] = '';
		}
		if (isset($fo['image_width'])) {
			$data['flyoutmenu_image_width'] = $fo['image_width'];
		} else {
		    $data['flyoutmenu_image_width'] = 120;
		}
		if (isset($fo['image_height'])) {
			$data['flyoutmenu_image_height'] = $fo['image_height'];
		} else {
		    $data['flyoutmenu_image_height'] = 120;
		}
		if (isset($fo['dropdowneffect'])) {
			$data['flyoutmenu_dropdowneffect'] = $fo['dropdowneffect'];
		} else {
		    $data['flyoutmenu_dropdowneffect'] = 'drop';
		}
		if (isset($fo['usehoverintent'])) {
			$data['flyoutmenu_usehoverintent'] = $fo['usehoverintent'];
		} else {
		    $data['flyoutmenu_usehoverintent'] = '';
		}
        
		
        if (isset($this->request->post[$preffix.'flyoutmenu_language'])) {
            $fl = $this->request->post[$preffix.'flyoutmenu_language'];
        } elseif ($this->config->get($preffix.'flyoutmenu_language')) {
            $fl = $this->config->get($preffix.'flyoutmenu_language');
        } else {
            $fl = array();
        }
		if (isset($fl['mobilemenuname'])) {
			$data['flyoutmenu_mobilemenuname'] = $fl['mobilemenuname'];
		} else {
		    $data['flyoutmenu_mobilemenuname'] = array();
		}
		if (isset($fl['more_title'])) {
			$data['flyoutmenu_more_title'] = $fl['more_title'];
		} else {
		    $data['flyoutmenu_more_title'] = array();
		}
		if (isset($fl['more2_title'])) {
			$data['flyoutmenu_more2_title'] = $fl['more2_title'];
		} else {
		    $data['flyoutmenu_more2_title'] = array();
		}
		if (isset($fl['infodname'])) {
			$data['flyoutmenu_infodname'] = $fl['infodname'];
		} else {
		    $data['flyoutmenu_infodname'] = array();
		}
		if (isset($fl['brandsdname'])) {
			$data['flyoutmenu_brandsdname'] = $fl['brandsdname'];
		} else {
		    $data['flyoutmenu_brandsdname'] = array();
		}
		if (isset($fl['latestpname'])) {
			$data['flyoutmenu_latestpname'] = $fl['latestpname'];
		} else {
		    $data['flyoutmenu_latestpname'] = array();
		}
		if (isset($fl['specialpname'])) {
			$data['flyoutmenu_specialpname'] = $fl['specialpname'];
		} else {
		    $data['flyoutmenu_specialpname'] = array();
		}
		if (isset($fl['featuredpname'])) {
			$data['flyoutmenu_featuredpname'] = $fl['featuredpname'];
		} else {
		    $data['flyoutmenu_featuredpname'] = array();
		}
		if (isset($fl['bestpname'])) {
			$data['flyoutmenu_bestpname'] = $fl['bestpname'];
		} else {
		    $data['flyoutmenu_bestpname'] = array();
		}
		if (isset($fl['viewallname'])) {
			$data['flyoutmenu_viewallname'] = $fl['viewallname'];
		} else {
		    $data['flyoutmenu_viewallname'] = array();
		}
		if (isset($fl['viewmorename'])) {
			$data['flyoutmenu_viewmorename'] = $fl['viewmorename'];
		} else {
		    $data['flyoutmenu_viewmorename'] = array();
		}
        
		if (isset($this->request->post[$preffix.'flyoutmenu_htmlarea1'])) {
			$data['flyoutmenu_htmlarea1'] = $this->request->post[$preffix.'flyoutmenu_htmlarea1'];
		} elseif ($this->config->get($preffix.'flyoutmenu_htmlarea1')) {
			$data['flyoutmenu_htmlarea1'] = $this->config->get($preffix.'flyoutmenu_htmlarea1');
		} else {
		    $data['flyoutmenu_htmlarea1'] = array();
		}
		if (isset($this->request->post[$preffix.'flyoutmenu_htmlarea2'])) {
			$data['flyoutmenu_htmlarea2'] = $this->request->post[$preffix.'flyoutmenu_htmlarea2'];
		} elseif ($this->config->get($preffix.'flyoutmenu_htmlarea2')) {
			$data['flyoutmenu_htmlarea2'] = $this->config->get($preffix.'flyoutmenu_htmlarea2');
		} else {
		    $data['flyoutmenu_htmlarea2'] = array();
		}
		if (isset($this->request->post[$preffix.'flyoutmenu_htmlarea3'])) {
			$data['flyoutmenu_htmlarea3'] = $this->request->post[$preffix.'flyoutmenu_htmlarea3'];
		} elseif ($this->config->get($preffix.'flyoutmenu_htmlarea3')) {
			$data['flyoutmenu_htmlarea3'] = $this->config->get($preffix.'flyoutmenu_htmlarea3');
		} else {
		    $data['flyoutmenu_htmlarea3'] = array();
		}
		if (isset($this->request->post[$preffix.'flyoutmenu_htmlarea4'])) {
			$data['flyoutmenu_htmlarea4'] = $this->request->post[$preffix.'flyoutmenu_htmlarea4'];
		} elseif ($this->config->get($preffix.'flyoutmenu_htmlarea4')) {
			$data['flyoutmenu_htmlarea4'] = $this->config->get($preffix.'flyoutmenu_htmlarea4');
		} else {
		    $data['flyoutmenu_htmlarea4'] = array();
		}
		if (isset($this->request->post[$preffix.'flyoutmenu_htmlarea5'])) {
			$data['flyoutmenu_htmlarea5'] = $this->request->post[$preffix.'flyoutmenu_htmlarea5'];
		} elseif ($this->config->get($preffix.'flyoutmenu_htmlarea5')) {
			$data['flyoutmenu_htmlarea5'] = $this->config->get($preffix.'flyoutmenu_htmlarea5');
		} else {
		    $data['flyoutmenu_htmlarea5'] = array();
		}
		if (isset($this->request->post[$preffix.'flyoutmenu_htmlarea6'])) {
			$data['flyoutmenu_htmlarea6'] = $this->request->post[$preffix.'flyoutmenu_htmlarea6'];
		} elseif ($this->config->get($preffix.'flyoutmenu_htmlarea6')) {
			$data['flyoutmenu_htmlarea6'] = $this->config->get($preffix.'flyoutmenu_htmlarea6');
		} else {
		    $data['flyoutmenu_htmlarea6'] = array();
		}
		if (isset($this->request->post[$preffix.'flyoutmenu_htmlarea7'])) {
			$data['flyoutmenu_htmlarea7'] = $this->request->post[$preffix.'flyoutmenu_htmlarea7'];
		} elseif ($this->config->get($preffix.'flyoutmenu_htmlarea7')) {
			$data['flyoutmenu_htmlarea7'] = $this->config->get($preffix.'flyoutmenu_htmlarea7');
		} else {
		    $data['flyoutmenu_htmlarea7'] = array();
		}
		if (isset($this->request->post[$preffix.'flyoutmenu_htmlarea8'])) {
			$data['flyoutmenu_htmlarea8'] = $this->request->post[$preffix.'flyoutmenu_htmlarea8'];
		} elseif ($this->config->get($preffix.'flyoutmenu_htmlarea8')) {
			$data['flyoutmenu_htmlarea8'] = $this->config->get($preffix.'flyoutmenu_htmlarea8');
		} else {
		    $data['flyoutmenu_htmlarea8'] = array();
		}
		
		$this->load->model('catalog/product');
		
		$data['products'] = array();
		
		if (isset($this->request->post[$preffix.'flyoutmenu_fproduct'])) {
			$products = $this->request->post[$preffix.'flyoutmenu_fproduct'];
		} elseif ($this->config->get($preffix.'flyoutmenu_fproduct')) {
			$products = $this->config->get($preffix.'flyoutmenu_fproduct');
		} else {
			$products = array();
		}	
		
		foreach ($products as $product_id) {
			$product_info = $this->model_catalog_product->getProduct($product_id);

			if ($product_info) {
				$data['products'][] = array(
					'product_id' => $product_info['product_id'],
					'name'       => $product_info['name']
				);
			}
		}
				
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/flyoutmenu.tpl', $data));
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/flyoutmenu')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		return !$this->error;
	}
	
	public function delete() {
		if ($this->validate() && (int)$this->request->get['menu_id']) {
			$this->language->load('module/flyoutmenu');
			$this->load->model('setting/setting');
			$preffix = 'menu'.(int)$this->request->get['menu_id'].'_';	
			$this->model_setting_setting->deleteSetting($preffix.'flyoutmenu');
			$this->session->data['success'] = $this->language->get('text_success_delete');
			$this->response->redirect($this->url->link('module/flyoutmenu', 'token=' . $this->session->data['token'], 'SSL'));
		} else {
			$this->response->redirect($this->url->link('module/flyoutmenu', 'token=' . $this->session->data['token'], 'SSL'));
		}
	}
}
?>