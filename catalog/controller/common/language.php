<?php
class ControllerCommonLanguage extends Controller {
	public function index() {
		$this->load->language('common/language');

		$data['text_language'] = $this->language->get('text_language');

		$data['action'] = $this->url->link('common/language/language', '', $this->request->server['HTTPS']);

		$data['code'] = $this->session->data['language'];

		$this->load->model('localisation/language');

		$data['languages'] = array();

		$results = $this->model_localisation_language->getLanguages();

		foreach ($results as $result) {
			if ($result['status']) {
				$data['languages'][] = array(
					'name'  => $result['name'],
					'code'  => $result['code'],
					'image' => $result['image']
				);
			}
		}

		if (!isset($this->request->get['route'])) {
			$data['redirect'] = $this->url->link('common/home');
		} else {
			$url_data = $this->request->get;

			unset($url_data['_route_']);

			$route = $url_data['route'];

			unset($url_data['route']);

			$url = '';

			if ($url_data) {
				$url = '&' . urldecode(http_build_query($url_data, '', '&'));
			}

			$data['redirect'] = $this->url->link($route, $url, $this->request->server['HTTPS']);
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/language.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/common/language.tpl', $data);
		} else {
			return $this->load->view('default/template/common/language.tpl', $data);
		}
	}

	public function language() {
        $plus_leng = '';
        $main_language = $this->model_localisation_language->getLanguagesMain();
        $main_language_code = $main_language[0]['code'];
        if (isset($this->request->post['code'])) {
            $this->session->data['language'] = $this->request->post['code'];
            if($this->request->post['code'] !== $main_language_code){
                $plus_leng = $this->request->post['code'] . '/';
            }
        }

        if (isset($this->request->post['redirect'])) {

            //нужно проверить $this->request->post['redirect'] на наличие уже там какой-то языковой составляющей и сначала все вычистить. а только потом редеректить
            $preredirect = $this->request->post['redirect'];
            foreach ($this->model_localisation_language->getLanguagesNotMain() as $item){
                $preredirect = str_replace("/". $item['code'] . "/", "/", $preredirect);
            }

            $redirect = str_replace(HTTP_SERVER, HTTP_SERVER.$plus_leng, $preredirect);

            $this->response->redirect($redirect);
        } else {
            $this->response->redirect($this->url->link('common/home'));
        }
	}
}