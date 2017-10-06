<?php
class ControllerCommonHeader extends Controller {
	public function index() {

		//var_dump('Группа клиента: '.$this->config->get('config_customer_group_id'));

		$data['title'] = $this->document->getTitle();

		if ($this->request->server['HTTPS']) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		/* All language, example on tpl $all_language['default']['code'] */
		$all_language = get_object_vars($this->language);
		$all_language = json_encode($all_language['group_data'], JSON_UNESCAPED_UNICODE);
		$data['all_language'] = json_decode($all_language, true);

		/* address, email */
		$data['address'] = $this->config->get('config_address');
		$data['email_c'] = $this->config->get('config_email');

		/* telephone */
		$data['telephone'] = $this->config->get('config_telephone');
		$data['telephone_2'] = $this->config->get('config_telephone_2');
		$data['telephone_3'] = $this->config->get('config_telephone_3');
		$data['telephone_4'] = $this->config->get('config_telephone_4');

		/* viber, whatsApp */
		$data['viber'] = $this->config->get('config_viber');
		$data['whatsApp'] = $this->config->get('config_telephone_5');

		/* Socail link */
		$data['config_vk'] = $this->config->get('config_vk');
		$data['config_facebook'] = $this->config->get('config_facebook');
		$data['config_twitter'] = $this->config->get('config_twitter');
		$data['config_instagram'] = $this->config->get('config_instagram');
		$data['config_vimeo'] = $this->config->get('config_vimeo');

		$data['base'] = $server;
		$data['description'] = $this->document->getDescription();
		$data['keywords'] = $this->document->getKeywords();
		$data['links'] = $this->document->getLinks();
		$data['styles'] = $this->document->getStyles();
		$data['scripts'] = $this->document->getScripts();
                // OCFilter start
                $data['noindex'] = $this->document->isNoindex();
                // OCFilter end
		$data['lang'] = $this->language->get('code');
		$data['direction'] = $this->language->get('direction');

		if ($this->config->get('config_google_analytics_status')) {
			$data['google_analytics'] = html_entity_decode($this->config->get('config_google_analytics'), ENT_QUOTES, 'UTF-8');
		} else {
			$data['google_analytics'] = '';
		}

		$data['name'] = $this->config->get('config_name');

		if (is_file(DIR_IMAGE . $this->config->get('config_icon'))) {
			$data['icon'] = $server . 'image/' . $this->config->get('config_icon');
		} else {
			$data['icon'] = '';
		}

		if (is_file(DIR_IMAGE . $this->config->get('config_logo'))) {
			$data['logo'] = $server . 'image/' . $this->config->get('config_logo');
		} else {
			$data['logo'] = '';
		}

		if (isset($this->request->get['path'])) {
			$path = '';

			$parts = explode('_', (string)$this->request->get['path']);

			$parts_last = (int)array_pop($parts);

			foreach ($parts as $path_id) {
				if (!$path) {
					$path = $path_id;
				} else {
					$path .= '_' . $path_id;
				}
			}
		}

		$this->load->language('common/header');

		$data['text_home'] = $this->language->get('text_home');
		$data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), (isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0));
		$data['text_shopping_cart'] = $this->language->get('text_shopping_cart');
		$data['text_logged'] = sprintf($this->language->get('text_logged'), $this->url->link('account/account', '', 'SSL'), $this->customer->getFirstName(), $this->url->link('account/logout', '', 'SSL'));

		$data['text_account'] = $this->language->get('text_account');
		$data['text_register'] = $this->language->get('text_register');
		$data['text_login'] = $this->language->get('text_login');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_transaction'] = $this->language->get('text_transaction');
		$data['text_download'] = $this->language->get('text_download');
		$data['text_logout'] = $this->language->get('text_logout');
		$data['text_checkout'] = $this->language->get('text_checkout');
		$data['text_category'] = $this->language->get('text_category');
		$data['text_all'] = $this->language->get('text_all');

		$data['home'] 			= $this->url->link('common/home');
		$data['wishlist'] 		= $this->url->link('account/wishlist', '', 'SSL');
		$data['logged'] 		= $this->customer->isLogged();
		$data['account'] 		= $this->url->link('account/account', '', 'SSL');
		$data['register'] 		= $this->url->link('account/register', '', 'SSL');
		$data['login'] 			= $this->url->link('account/login/ajax2login', '', 'SSL');
		$data['order'] 			= $this->url->link('account/order', '', 'SSL');
		$data['transaction'] 	= $this->url->link('account/transaction', '', 'SSL');
		$data['download'] 		= $this->url->link('account/download', '', 'SSL');
		$data['logout'] 		= $this->url->link('account/logout', '', 'SSL');
		$data['shopping_cart'] 	= $this->url->link('checkout/checkout');
		$data['checkout'] 		= $this->url->link('checkout/checkout', '', 'SSL');
		$data['contact'] 		= $this->url->link('information/contact', '', 'SSL');

		$data['text_returning_customer'] = $this->language->get('heading_title');

		$data['text_new_customer'] = $this->language->get('text_new_customer');
		$data['text_register'] = $this->language->get('text_register');
		$data['text_register_account'] = $this->language->get('text_register_account');
		$data['text_returning_customer'] = $this->language->get('text_returning_customer');
		$data['text_i_am_returning_customer'] = $this->language->get('text_i_am_returning_customer');
		$data['text_forgotten'] = $this->language->get('text_forgotten');

		$data['entry_email'] = $this->language->get('entry_email');
		$data['entry_password'] = $this->language->get('entry_password');

		$data['button_continue'] = $this->language->get('button_continue');
		$data['button_login'] = $this->language->get('button_login');

		$data['forgotten'] = $this->url->link('account/forgotten', '', 'SSL');

		$data['contact'] = $this->url->link('information/contact', '', 'SSL');
		$data['text_contact'] = $this->language->get('text_contact');
		$data['text_callme'] = $this->language->get('text_callme');

		$data['content_header'] = $this->load->controller('common/content_header');
		$data['mainmenu'] = $this->load->controller('common/mainmenu');

		$status = true;
		
		// Modal show isLogged
		$isLogged = $this->customer->isLogged();

		if ( $isLogged ) {
			if ($this->session->data['loggedFirst'] != 'check') {
				$this->session->data['loggedFirst'] = 'on';
			}
		} else {
			$this->session->data['loggedFirst'] = 'off';
		}

		$data['loggedFirst'] = $this->session->data['loggedFirst'];

		if ( $this->session->data['loggedFirst'] == 'on' ) {
			$this->session->data['loggedFirst'] = 'check';
		}

		$data['text_hell'] = sprintf($this->language->get('text_hell'), $this->customer->getFirstName() . '&nbsp;' . $this->customer->getLastName());
		$data['desc_hell'] = $this->language->get('desc_hell');
		
		if (isset($this->request->server['HTTP_USER_AGENT'])) {
			$robots = explode("\n", str_replace(array("\r\n", "\r"), "\n", trim($this->config->get('config_robots'))));

			foreach ($robots as $robot) {
				if ($robot && strpos($this->request->server['HTTP_USER_AGENT'], trim($robot)) !== false) {
					$status = false;

					break;
				}
			}
		}

		// Menu
		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$data['categories'] = array();

		$categories = $this->model_catalog_category->getCategories(0);

		foreach ($categories as $category) {
			if ( $category['top'] && ($this->config->get('config_customer_group_id') == $category['customer_group_id'] || $category['customer_group_id'] == '1') ) {
				// Level 2
				$children_data = array();

				$children = $this->model_catalog_category->getCategories($category['category_id']);

				foreach ($children as $child) {
					$filter_data = array(
						'filter_category_id'  => $child['category_id'],
						'filter_sub_category' => true
					);

					$children_data[] = array(
						'name'  => $child['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
						'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])
					);
				}

				$active_category = false;
				if ( isset($this->request->get['path']) ) {
					if ($parts_last == $category['category_id']) {
						$active_category = 'active';
					}

					if ( !empty($parts[0]) && $parts[0] == $category['category_id'] ) {
						$active_category = 'active';
					}
				}

				// Level 1
				$data['categories'][] = array(
					'name'     	=> $category['name'],
					'active'  	=> $active_category,
					'children' 	=> $children_data,
					'column'   	=> $category['column'] ? $category['column'] : 1,
					'href'     	=> $this->url->link('product/category', 'path=' . $category['category_id'])
				);
			}
		}

		$this->load->model('catalog/information');

		$data['informations'] = array();

		foreach ($this->model_catalog_information->getInformations() as $result) {
			if ($result['top']) {
				$data['informations'][] = array(
					'title' => $result['title'],
					'href'  => $this->url->link('information/information', 'information_id=' . $result['information_id'])
				);
			}
		}

		$data['language'] = $this->load->controller('common/language');
		$data['currency'] = $this->load->controller('common/currency');
		$data['search'] = $this->load->controller('common/search');
		$data['cart'] = $this->load->controller('common/cart');
		$data['slideshow'] = $this->load->controller('common/slideshow');

		// For page specific css
		if (isset($this->request->get['route'])) {
			if (isset($this->request->get['product_id'])) {
				$class = '-' . $this->request->get['product_id'];
			} elseif (isset($this->request->get['path'])) {
				$class = '-' . $this->request->get['path'];
			} elseif (isset($this->request->get['manufacturer_id'])) {
				$class = '-' . $this->request->get['manufacturer_id'];
			} else {
				$class = '';
			}

			$data['class'] = str_replace('/', '-', $this->request->get['route']) . $class;
		} else {
			$data['class'] = 'common-home';
		}

		$data['languagese'] = $this->language->getGroupData();

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/header.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/common/header.tpl', $data);
		} else {
			return $this->load->view('default/template/common/header.tpl', $data);
		}
	}
}