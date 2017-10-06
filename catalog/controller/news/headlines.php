<?php
class ControllernewsHeadlines extends Controller {
	public function index() {
		$this->response->redirect($this->url->link('news/ncategory'));
  	}
}
?>