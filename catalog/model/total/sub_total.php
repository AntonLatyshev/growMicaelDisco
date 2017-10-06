<?php
class ModelTotalSubTotal extends Model {
	public function getTotal(&$total_data, &$total, &$taxes) {
		$this->load->language('total/sub_total');

		$sub_total = $this->cart->getSubTotal();

		if (isset($this->session->data['vouchers']) && $this->session->data['vouchers']) {
			foreach ($this->session->data['vouchers'] as $voucher) {
				$sub_total += $voucher['amount'];
			}
		}

		$total_data[] = array(
			'code'       => 'sub_total',
			'title'      => $this->num2word($this->cart->countProducts(), array( sprintf($this->language->get('text_cart_1'), $this->cart->countProducts()), sprintf($this->language->get('text_cart_2'), $this->cart->countProducts()), sprintf($this->language->get('text_cart_3'), $this->cart->countProducts())), $this->cart->countProducts()),
			'value'      => $sub_total,
			'sort_order' => $this->config->get('sub_total_sort_order')
		);

		$total += $sub_total;
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