<?php

class ControllerMarkupMarkup extends Controller
{
  public function index()
  {
    $params = $this->request->get;
    if (count($params) === 1) {
      $file = DIR_MARKUP . 'index.html';
    } else {
      $file = DIR_MARKUP . $params['page'];
    }
    if (file_exists($file)) {
      require $file;
    } else {
      trigger_error('Error: Could not load file ' . $file . '!');
    }
		exit(); 
  }
}
