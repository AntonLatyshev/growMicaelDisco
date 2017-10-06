<?php
class ControllerModuleSlideshow extends Controller {
	public function index($setting) {
		static $module = 0;

		$this->load->model('design/banner');
		$this->load->model('tool/image');

//		$this->document->addStyle('catalog/view/javascript/jquery/owl-carousel/owl.carousel.css');
//		$this->document->addScript('catalog/view/javascript/jquery/owl-carousel/owl.carousel.min.js');

		$data['banners'] = array();

		$lang = $this->language->get('code');

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

				$image = $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']);

//				if ( $lang == 'uk' ) {
//					$image = $this->model_tool_image->resize($result['image_ua'], $setting['width'], $setting['height']);
//				}
//				if ( $lang == 'en' ) {
//					$image = $this->model_tool_image->resize($result['image_en'], $setting['width'], $setting['height']);
//				}

				$data['banners'][] = array(
					'title' 	=> $result['title'],
					'link'  	=> $link,
					'image' 	=> $image
				);
			}
		}

		$data['module'] = $module++;

		$data['languagese'] = $this->language->getGroupData();

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/slideshow.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/module/slideshow.tpl', $data);
		} else {
			return $this->load->view('default/template/module/slideshow.tpl', $data);
		}
	}
}