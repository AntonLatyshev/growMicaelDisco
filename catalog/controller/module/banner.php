<?php
class ControllerModuleBanner extends Controller {
	public function index($setting) {
		static $module = 0;

		$this->load->model('design/banner');
		$this->load->model('tool/image');

//		$this->document->addStyle('catalog/view/javascript/jquery/owl-carousel/owl.carousel.css');
//		$this->document->addStyle('catalog/view/javascript/jquery/owl-carousel/owl.transitions.css');
//		$this->document->addScript('catalog/view/javascript/jquery/owl-carousel/owl.carousel.min.js');

		$data['banners'] = array();

		$results = $this->model_design_banner->getBanner($setting['banner_id']);

		foreach ($results as $result) {

			// Seo url
			$link = $result['link'];

			$string_url = array(
				0 => "product/category&amp;path",
				1 => "product/product&amp;product_id",
				2 => "information/information&amp;information_id"
			);

			$routeUrl = explode('=', $result['link']);

			foreach ($string_url as $key => $value) {

				if ( in_array($value, $routeUrl) ) {
					switch ($key) {
						case 0:
							if (!empty($routeUrl[2])) {
								$link = $this->url->link('product/category', 'path=' . $routeUrl[2]);
							}
							break;
						case 1:
							if (!empty($routeUrl[2])) {
								$link = $this->url->link('product/product', 'product_id=' . $routeUrl[2]);
							}
							break;
						case 2:
							if (!empty($routeUrl[2])) {
								$link = $this->url->link('information/information', 'information_id=' . $routeUrl[2]);
							}
							break;
					}
				}

			}

			if (is_file(DIR_IMAGE . $result['image'])) {
				$data['banners'][] = array(
					'title' => $result['title'],
					'link'  => $link,
					'image' => $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height'])
				);
			}
		}

		$data['module'] = $module++;

		$file_tpl = 'banner';
		if ( !empty($setting['name_tpl']) ) {
			$file_tpl = $setting['name_tpl'];
		}

		$data['languagese'] = $this->language->getGroupData();

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/' . $file_tpl . '.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/module/' . $file_tpl . '.tpl', $data);
		} else {
			echo 213;
			return $this->load->view('default/template/module/' . $file_tpl . '.tpl', $data);
		}
	}
}