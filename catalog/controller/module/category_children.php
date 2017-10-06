<?php
class ControllerModuleCategoryChildren extends Controller {
	public function index($setting) {

		$this->load->language('module/category_children');

		$data['heading_title'] = $this->language->get('heading_title');

		if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
		} else {
			$parts = array();
		}

		if (isset($parts[0])) {
			$data['category_id'] = $parts[0];
		} else {
			$data['category_id'] = 0;
		}

		if (isset($parts[1])) {
			$data['child_id'] = $parts[1];
		} else {
			$data['child_id'] = 0;
		}

		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$data['categories'] = array();

		$categories = $this->model_catalog_category->getCategories($setting['category_children_id']);

		foreach ($categories as $category) {
			if ( $category['top'] && $this->config->get('config_customer_group_id') == $category['customer_group_id'] || $category['customer_group_id'] == '1' ) {
				$children_data = array();

				/*if ($category['category_id'] == $data['category_id']) {*/

				$children = $this->model_catalog_category->getCategories($category['category_id']);

				foreach ($children as $child) {
					$filter_data = array('filter_category_id' => $child['category_id'], 'filter_sub_category' => true);

					if ($child['image']) {
						$image = $this->model_tool_image->resize($child['image'], 190, 190);
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', 190, 190);
					}

					$children_data[] = array(
						'category_id' => $child['category_id'],
						'thumb' => $image,
						'name' => $child['name'],
						'href' => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])
					);
				}
				/*}*/

				$filter_data = array(
					'filter_category_id' => $category['category_id'],
					'filter_sub_category' => true
				);

				$data['categories'][] = array(
					'category_id' => $category['category_id'],
					'name' => $category['name'],
					'children' => $children_data,
					'href' => $this->url->link('product/category', 'path=' . $category['category_id'])
				);
			}
		}

		$data['languagese'] = $this->language->getGroupData();

		if ( !empty($setting['template_name']) ) {
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/' . $setting['template_name'] . '.tpl')) {
				return $this->load->view($this->config->get('config_template') . '/template/module/' . $setting['template_name'] . '.tpl', $data);
			} else {
				return $this->load->view('default/template/module/' . $setting['template_name'] . '.tpl', $data);
			}
		} else {
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/category_children.tpl')) {
				return $this->load->view($this->config->get('config_template') . '/template/module/category_children.tpl', $data);
			} else {
				return $this->load->view('default/template/module/category_children.tpl', $data);
			}
		}
	}
}