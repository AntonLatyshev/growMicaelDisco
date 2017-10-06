<?php 
class ControllerCatalogSeries extends Controller {
	private $error = array();
	private $messages = array();

	public function index() {
		$this->load->model('catalog/series');
		$this->getList();
	}

	public function insert() {
		$this->load->model('catalog/series');
                $this->load->language('catalog/series');
		if(isset($this->request->post['name']) && $this->request->post['name']) {
			$series_id = $this->model_catalog_series->addSeries($this->request->post['name']);
			if($series_id) {
                                $json = array(
                                        'status' => $this->language->get('text_ok'),
                                        'message' => $this->language->get('text_series_succes'),
                                        'series_id' => $series_id
                                );
			} else {
                                $json = array(
                                        'status' => $this->language->get('text_error'),
                                        'message' => $this->language->get('text_series_warning'),
                                        'series_id' => false
                                );                                
			}
		} else {
                                $json = array(
                                        'status' => $this->language->get('text_error'),
                                        'message' => $this->language->get('text_series_noname'),
                                        'series_id' => false
                                );                           
		}
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));                
	}

	public function update() {
		$this->load->model('catalog/series');
		$this->getForm();
	}

	public function delete() {
		$this->load->model('catalog/series');
                $this->load->language('catalog/series');
		if(isset($this->request->post['series_id'])) {
			$this->model_catalog_series->deleteSeries($this->request->post['series_id']);
			$json = array(
				'status' => $this->language->get('text_ok'),
				'message' => $this->language->get('text_series_delete')
			);                        
		} else {
			$json = array(
				'status' => $this->language->get('text_error'),
				'message' => $this->language->get('text_series_cant_del')
			);
		}
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));                 
	}
	
	public function unlink() {
		if(isset($this->request->post['product_id']) && isset($this->request->post['series_id'])) {
			$this->load->model('catalog/series');
                        $this->load->language('catalog/series');
			$this->model_catalog_series->deleteProductFromSeries($this->request->post['product_id'], $this->request->post['series_id']);
			$json = array(
				'status' => $this->language->get('text_ok'),
				'message' => $this->language->get('text_prod_unlock')
			);                          
		} else {
			$json = array(
				'status' => $this->language->get('text_error'),
				'message' => $this->language->get('text_prod_cant_unlock')
			);                        
		}
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json)); 
	}
	
	public function link() {
		if(isset($this->request->post['product_id']) && isset($this->request->post['series_id'])) {
			$this->load->model('catalog/series');
                        $this->load->language('catalog/series');
			$link_id = $this->model_catalog_series->addProductToSeriesById($this->request->post['product_id'], $this->request->post['series_id']);
			if($link_id) {
                                $json = array(
                                        'status' => $this->language->get('text_ok'),
                                        'message' => $this->language->get('text_prod_lock')
                                );                                    
			} else {
                                $json = array(
                                        'status' => $this->language->get('text_error'),
                                        'message' => $this->language->get('text_prod_cant_lock')
                                );                                
			}
		} else {
                                $json = array(
                                        'status' => $this->language->get('text_error'),
                                        'message' => $this->language->get('text_take_prod')
                                );                          
		}
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));                 
	}

	public function autocomplete() {
		if(isset($this->request->get['series_name']) && $this->request->get['series_name']) {
			$this->load->model('catalog/series');
			$series = $this->model_catalog_series->getSeriesByName($this->request->get['series_name']);
			exit(json_encode($series));
		}
	}
	
	protected function getList() {
		$data['add_series_href'] = $this->url->link('catalog/series/insert', 'token=' . $this->session->data['token']);
                $data['del_series_href'] = $this->url->link('catalog/series/delete', 'token=' . $this->session->data['token']);
                $data['to_main'] = $this->url->link('common/dashboard', 'token=' . $this->session->data['token']);
                $data['to_series'] = $this->url->link('catalog/series', 'token=' . $this->session->data['token']);
		
		$series = $this->model_catalog_series->getSeries();
		foreach ($series as $single) {
			$data['series'][] = array(
				'name' => $single['name'],
				'href' => $this->url->link('catalog/series/update', 'series_id=' . $single['series_id'] . '&token=' . $this->session->data['token']),
				'series_id' => $single['series_id'],
				'delete' => $this->url->link('catalog/series/delete', 'series_id=' . $single['series_id'] . '&token=' . $this->session->data['token']),
			);
		}

                $data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('catalog/series_list.tpl', $data));                
	}

	protected function getForm() {

		if( isset($this->request->get['series_id']) && (int)$this->request->get['series_id'] ) {

			$series = $this->model_catalog_series->getSeries($this->request->get['series_id']);

            $data['series_id'] = $this->request->get['series_id'];
			$data['series_name'] = $series['name'];
			$data['add_product_href'] = $this->url->link('catalog/series/link', 'token=' . $this->session->data['token']);
			$data['change_main_product_href'] = $this->url->link('catalog/series/mainProduct', 'token=' . $this->session->data['token']);
            $data['del_prod_href'] = $this->url->link('catalog/series/unlink', 'token=' . $this->session->data['token']);

			$products = $this->model_catalog_series->getSeriesProducts($this->request->get['series_id']);

            $data['to_series'] = $this->url->link('catalog/series', 'token=' . $this->session->data['token']);

			$this->load->model('tool/image');

			foreach ($products as $product) {
				if(!empty($product['product_id'])) {
					$data['products'][] = array(
						'name'          => $product['name'],
						'model'         => $product['model'],
						'sku'           => $product['sku'],
						'category'      => $product['category'],
						'manufacturer_name' => $product['manufacturer'],
						'is_main'       => $product['is_main'],
						'product_id'    => $product['product_id'],
						'image'         => $this->model_tool_image->resize(($product['image'] ? $product['image'] : 'no_image.jpg'), 40, 40),
						'href'          => $this->url->link('catalog/product/edit', 'product_id=' . $product['product_id'] . '&token=' . $this->session->data['token']),
						'delete'        => $this->url->link('catalog/series/unlink', 'series_id=' . (int)$this->request->get['series_id'] . '&product_id=' . $product['product_id'] . '&token=' . $this->session->data['token']),
					);
				} 
			}
		} else {
			$this->response->redirect($this->url->link('catalog/series', 'token=' . $this->session->data['token']));
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
        $data['token'] = $this->session->data['token'];

		$this->response->setOutput($this->load->view('catalog/series_form.tpl', $data));

	}

        public function mainProduct() {
                if(isset($this->request->post['product_id']) && isset($this->request->post['series_id'])) {
                        $this->load->model('catalog/series');
                        $this->model_catalog_series->changeMainProduct($this->request->post['product_id'], $this->request->post['series_id']);
                        exit(json_encode('ok'));
                } else {
                        exit(json_encode('error'));
                }
        }
}