<?php
class ModelTotalTotal extends Model {
	public function getTotal(&$total_data, &$total, &$taxes) {
		
		$this->load->language('total/total');

		$total_data[] = array(
			'code'       => 'total',
			'title'      => $this->language->get('text_total'),
			'value'      => max(0, $total),
			'sort_order' => $this->config->get('total_sort_order')
		);
	}

	private function num2word($num, $words)
	{
		$num = $num % 100;
		if ($num > 19) {
			$num = $num % 10;
		}
		switch ($num) {
			case 1: {
				return($words[0]);
			}
			case 2: case 3: case 4: {
			return($words[1]);
		}
			default: {
				return($words[2]);
			}
		}
	}
	
}