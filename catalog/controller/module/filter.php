<?php
class ControllerModuleFilter extends Controller {
	public function index() {
		if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
		} else {
			$parts = array();
		}
                
		$category_id = end($parts);
                
                if (isset($this->request->get['search'])) {
			$search = $this->request->get['search'];
		} else {
			$search = '';
		}

		$this->load->model('module/filter');
                
                
                
                $filter_data = array(
                    'filter_category_id' => $category_id,
                    'filter_name'        => $search,
                );
                
                $options = $this->model_module_filter->getFilterOptions($filter_data);
                echo "<pre>";
                    print_r($options);
                echo "</pre>";
              

		
	}
}